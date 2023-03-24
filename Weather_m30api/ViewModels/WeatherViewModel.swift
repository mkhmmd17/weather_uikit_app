import Foundation
import Combine

class WeatherViewModel {
    
    private let networkManager = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var forecasts: [Forecast]?
    @Published var error: Error?
    
    func fetchWeatherForecast(location: String, days: Int) {
        networkManager.fetchWeatherForecast(location: location, days: days)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            }, receiveValue: { forecast in
                self.forecasts = forecast.forecast
                print(forecast)
            })
            .store(in: &cancellables)
    }
    
}
