import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case httpError(Int)
    case decodingError(Error)
}


class NetworkManager {
    private let baseURL = "https://api.m3o.com/v1/weather"
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    private let apiKey = "N2EwMTRlMjktYzEwMC00ZGQ5LTliNmMtMTY4NGVjNzI1ODIw"
    
    func fetchWeatherForecast(location: String, days: Int) -> AnyPublisher<WeatherForecastResponse, NetworkError> {
        guard let url = URL(string: "\(baseURL)/Forecast") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let requestBody = ["location": location, "days": days] as [String: Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            return Fail(error: NetworkError.decodingError(error)).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.httpError((response as? HTTPURLResponse)?.statusCode ?? 0)
                }
                return data
            }
            .decode(type: WeatherForecastResponse.self, decoder: decoder)
            .mapError { NetworkError.decodingError($0) }
            .eraseToAnyPublisher()
    }
}



