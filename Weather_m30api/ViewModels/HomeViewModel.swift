import Foundation
import Combine

class HomeViewModel {
    
    @Published var weatherData: [Forecast] = []
    @Published var days: Int = 0
    @Published var city: String = ""
    @Published var isLoading: Bool = false
    
    
    func getWeatherData() {
        Task {
            isLoading = true
            do {
                let forecast = try await NetworkManager.shared.getWeatherForecast(for: city, days: days)
                Task { @MainActor in
                    self.weatherData = forecast.forecast
                    print(self.weatherData)
                    isLoading = false
                }
            } catch {
                print(error)
            }
        }
    }
}
