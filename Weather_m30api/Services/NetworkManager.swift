import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
}

class NetworkManager {
    let baseURL = "https://api.m3o.com/v1"
    let session = URLSession.shared
    let decoder = JSONDecoder()
    let apiKey = "M2YwMTE5YjEtMGE1NS00MjEzLWJkMjctZDQ0NTJiMWRlNTc0"
    
    private init() {
        
    }
    
    static var shared = NetworkManager()
    
    func getWeatherForecast(for location: String, days: Int) async throws -> WeatherForecast {
        let endpoint = "/weather/Forecast"
        let urlString = "\(baseURL)\(endpoint)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        let requestBody = ["location": location, "days": days] as [String : Any]
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      throw NetworkError.invalidResponse
            }
        return try decoder.decode(WeatherForecast.self, from: data)
    }
}


