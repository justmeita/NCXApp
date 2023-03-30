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
In this funcion we need a parameter that is a closure returning nothing that handles either our needed data or an error. The data handled by this closure will be used later in the function call.
```swift
func getWeatherHandler(coord: Coord, completionHandler: @escaping (WeatherInfo?, Error?) -> Void) {
    
    [...]       //This is the part where the url is made using the URLComponents structure
    
    let task = URLSession.shared.dataTask(with: url.url!) { data, response, error in    //ulr.url is needed to convert
        if let error = error{                                                           //URLComponents in URL
            completionHandler(nil, error)       //If the call returns an error, the completion handler
        }                                       //will return no result and the error received 
        if let data = data , let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            DispatchQueue.main.async {          //Once we make sure the request has gone through, we move
                let decoder = JSONDecoder()     //the function to a different thread and go on with the
                var weather : WeatherInfo?      //synchronous code while the API call finishes
                
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
```

## Async/Awaiy
The main difference here is the 'async' keyword in the function declaration which tells us that this must be later called with the 'await' keyword in a scope that supports asynchronous calls (later we'll call this function into a Task, the Swift manager for multiple threads usage)
```swift
func getWeatherAsync(coord: Coord) async throws -> WeatherInfo? {

[...]   //This is the part where the url is made using the URLComponents structure

do {
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url.url!))        //ulr.url is needed to convert
                                                                                                //URLComponents in URL
        let decoder = JSONDecoder()
        
        do {
            weather = try decoder.decode(WeatherInfo.self, from: data)
            
            return weather              //Since we have no completion handler, we can simply
        } catch {                       //return the data once decoded, or nothing if the call
            print(error)                //fails
        }
    } catch {
        print(error)
    }
    
    return nil
    
}
```

## Combine
This is the most different way of making an API call, because it involves a different coding paradygm, called **Reactive Programming**. It's all based on the Publisher/Subscriber model, in which every time a Publisher makes a certain action a Subscriber is notified and will act accordingly.
In this case, the URLSession used to make a call has a built-in Publisher called _.dataTaskPublisher_, we'll use that to notify another built-in Subscriber that gets created when using the _.sink_ method.

This is the dedicated ViewModel for the API call using Combine, the _cancellables_ variable is needed to cancel the subscription of _.sink_ when it has finished transferring data.
```swift
class WeatherViewModel : ObservableObject {
    @Published var currentWeatherCombine = WeatherInfo()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        currentWeatherCombine = WeatherInfo()
    }
}
```
This is the function. It goes through a series of steps to get the data, decode it and cancel the subscription at the end.
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

## Using the functions
```swift
getWeatherHandler(coord: coords[0]) { weather, error in
                     if let newWeather = weather {
                         currentWeather[0] = newWeather
                        }
                     }
                    
                    Task {
                        currentWeather[1] = try await getWeatherAsync(coord: coordinates) ?? WeatherInfo()      //The coordinates variable is not in
                    }                                                                                           //the array because XCode bugged and 
                                                                                                                //didn't accept an array element
                    vm.getWeatherCombine(coord: coords[1])
```
