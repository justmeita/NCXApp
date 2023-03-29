//
//  ViewModel.swift
//  NCXApp
//
//  Created by Letterio Ugo Cangiano on 29/03/23.
//

import Foundation
import Combine

class WeatherViewModel : ObservableObject {
    @Published var currentWeatherCombine = WeatherInfo()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        currentWeatherCombine = WeatherInfo()
    }
    
    func getWeatherCombine(coord: Coord) {
        var url = URLComponents(string: "https://api.openweathermap.org")!
        
        url.path = "/data/2.5/weather"
        
        url.queryItems = [
            URLQueryItem(name: "lat", value: "\(coord.lat ?? 0.0)"),
            URLQueryItem(name: "lon", value: "\(coord.lon ?? 0.0)"),
            URLQueryItem(name: "appid", value: "3f82ad8e7e67f991e05855ce600b049a"),
            URLQueryItem(name: "units", value: "metric")
        ]
        URLSession.shared
            .dataTaskPublisher(for: url.url!)
            .receive(on: DispatchQueue.main)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: WeatherInfo.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    print(error)
                }
            }, receiveValue: { newWeather in
                self.currentWeatherCombine = newWeather
            })
            .store(in: &self.cancellables)
        
        
        
    }
}
