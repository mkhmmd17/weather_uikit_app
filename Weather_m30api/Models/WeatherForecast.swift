//MARK: - WeatherForecast
import Foundation

// MARK: - Weather
struct WeatherForecastResponse: Codable {
    
    let location: String
    let forecast: [WeatherForecast]

    enum CodingKeys: String, CodingKey {
        case location
        case forecast
    }
}

// MARK: - Forecast
struct WeatherForecast: Codable {
    let date: String
    let maxTempC, minTempC: Double

    enum CodingKeys: String, CodingKey {
        case date
        case maxTempC = "max_temp_c"
        case minTempC = "min_temp_c"
    }
}
