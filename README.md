# Swift Concurrency
Hello everyone, this is a simple project showcasing different ways to implement concurrent programming in Swift

## Description
This app displays the weather in three different regions you can choose with the dedicated search bar. Once you're happy with the locations you've picked, tapping the Update View button will make three different API calls with the three different ways of making asynchronous calls: DispatchQueue and completion handlers, Async/Await and Combine.

## Installation and usage

1. Clone the project
2. Open it in XCode
3. Build it and run it on the simulator or your iPhone

To effectively test this project you have to do the following, once you've open the app:

1. Write at least one name of a city in the search bar and tap "Search"
2. A message will pop up telling you for which method you've picked the location
3. Tap "OK" to continue
4. Repeat steps 1 to 3 to add more locations (max. 3)
5. Tap "Update View" to make the calls and see the weather info

## DispatchQueue and Completion Handler

```swift
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
```

## Async/Awaiy

```swift
func getWeatherAsync(coord: Coord) async throws -> WeatherInfo? {

[...]

do {
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url.url!))

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
```

## Combine
Viewmodel
```swift
class WeatherViewModel : ObservableObject {
    @Published var currentWeatherCombine = WeatherInfo()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        currentWeatherCombine = WeatherInfo()
    }
}
```
Function
```swift
func getWeatherCombine(coord: Coord) {

       [...]
       
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
```

## Making the calls
```swift
getWeatherHandler(coord: coords[0]) { weather, error in
                     if let newWeather = weather {
                         currentWeather[0] = newWeather
                        }
                     }
                    
                    
                    Task {
                        currentWeather[1] = try await getWeatherAsync(coord: coordinates) ?? WeatherInfo()
                    }
                    
                    vm.getWeatherCombine(coord: coords[1])
```
