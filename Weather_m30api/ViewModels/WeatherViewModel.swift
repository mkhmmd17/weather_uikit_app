import Foundation
import Combine

//Create View States with Enum
enum WeatherViewActions {
    case showAlert(String)
    case loading(Bool)
    case updateWeather(forecasts: [WeatherForecast]?)
}

class WeatherViewModel {
    
    //Create PassthroughtSubject which we will be subscribe in our View
    private let weatherViewActionSubject = PassthroughSubject<WeatherViewActions, Never>()
    private(set) lazy var weatherViewActionPublisher = weatherViewActionSubject.eraseToAnyPublisher()
    
    private let networkManager = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    private var forecasts: [WeatherForecast]?
    
    func fetchWeatherForecast(location: String, days: Int) {
        Task {
            weatherViewActionSubject.send(.loading(true))
            
            defer {
                weatherViewActionSubject.send(.loading(false))
            }
            
            do {
                let result = try await networkManager.fetchWeatherForecast(location: location, days: days)
                forecasts = result.forecast
                weatherViewActionSubject.send(.updateWeather(forecasts: forecasts))
            } catch {
                weatherViewActionSubject.send(.showAlert(error.localizedDescription))
            }
        }
    }
    
}
