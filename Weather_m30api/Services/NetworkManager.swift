import Foundation

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
    
    func fetchWeatherForecast(location: String, days: Int) async throws -> WeatherForecastResponse {
        guard let url = URL(string: "\(baseURL)/Forecast") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let requestBody = ["location": location, "days": days] as [String: Any]
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        
        let (data, _) = try await session.data(for: request)
        
        let result = try JSONDecoder().decode(WeatherForecastResponse.self, from: data)
        return result
    }
}



