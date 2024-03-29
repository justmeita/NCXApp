//
//  API Calls.swift
//  NCXApp
//
//  Created by Letterio Ugo Cangiano on 23/03/23.
//

import Foundation
import Combine

func getWeatherAsync(coord: Coord) async throws -> WeatherInfo? {
    
    var weather: WeatherInfo
    
    var url = URLComponents(string: "https://api.openweathermap.org")!
    
    url.path = "/data/2.5/weather"
    
    url.queryItems = [
        URLQueryItem(name: "lat", value: "\(coord.lat ?? 0.0)"),
        URLQueryItem(name: "lon", value: "\(coord.lon ?? 0.0)"),
        URLQueryItem(name: "appid", value: "3f82ad8e7e67f991e05855ce600b049a"),
        URLQueryItem(name: "units", value: "metric")
    ]
    
    //print(url)
    do {
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url.url!))
        //print(response)
        let decoder = JSONDecoder()
        
        do {
            weather = try decoder.decode(WeatherInfo.self, from: data)
            
            return weather
        } catch {
            print(error)
        }
    } catch {
        print(error)
    }
    
    return nil
    
}

func getWeatherHandler(coord: Coord, completionHandler: @escaping (WeatherInfo?, Error?) -> Void) {
    
    var url = URLComponents(string: "https://api.openweathermap.org")!
    
    url.path = "/data/2.5/weather"
    
    url.queryItems = [
        URLQueryItem(name: "lat", value: "\(coord.lat ?? 0.0)"),
        URLQueryItem(name: "lon", value: "\(coord.lon ?? 0.0)"),
        URLQueryItem(name: "appid", value: "3f82ad8e7e67f991e05855ce600b049a"),
        URLQueryItem(name: "units", value: "metric")
    ]
    
    let task = URLSession.shared.dataTask(with: url.url!) { data, response, error in
        if let error = error{
            completionHandler(nil, error)
        }
        if let data = data , let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            DispatchQueue.main.async {
                let decoder = JSONDecoder()
                var weather : WeatherInfo?
                
                do {
                    weather = try decoder.decode(WeatherInfo.self, from: data)
                    
                    completionHandler(weather, nil)
                } catch {
                    print(error)
                    completionHandler(nil, error)
                }
            }
        }
        else {
            completionHandler(nil, (assertionFailure("Invalid Server Response") as! Error))
        }
    }
    task.resume()
}

/*func getWeatherCombine(coord: Coord) -> Future<WeatherInfo, Error> {
    var url = URLComponents(string: "https://api.openweathermap.org")!
    
    url.path = "/data/2.5/weather"
    
    url.queryItems = [
        URLQueryItem(name: "lat", value: "\(coord.lat ?? 0.0)"),
        URLQueryItem(name: "lon", value: "\(coord.lon ?? 0.0)"),
        URLQueryItem(name: "appid", value: "3f82ad8e7e67f991e05855ce600b049a"),
        URLQueryItem(name: "units", value: "metric")
    ]
    
    return Future() { promise in
        URLSession.shared
            .dataTaskPublisher(for: url.url!)
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
                    promise(.failure(error))
                }
            }, receiveValue: {
                promise(.success($0))
            })
    }
    
}*/

func getCoords(name: String) async -> Coord? {
    
    var url = URLComponents(string: "https://api.openweathermap.org")!
    
    url.path = "/geo/1.0/direct"
    
    url.queryItems = [
        URLQueryItem(name: "q", value: name),
        URLQueryItem(name: "limit", value: "1"),
        URLQueryItem(name: "appid", value: "3f82ad8e7e67f991e05855ce600b049a")
    ]
    
    do {
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url.url!))
        //print(response)
        let decoder = JSONDecoder()
        var coordInfo = GeocoderInfo()
        
        do {
            coordInfo = try decoder.decode(GeocoderInfo.self, from: data)
            
            var coords = Coord()
            coords.lat = coordInfo[0].lat
            coords.lon = coordInfo[0].lon
            
            return coords
            
        } catch {
            print(error)
        }
    } catch {
        print(error)
    }
    
    return nil
}
