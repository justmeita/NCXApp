//
//  ContentView.swift
//  NCXApp
//
//  Created by Letterio Ugo Cangiano on 28/03/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var currentWeather = [WeatherInfo(),WeatherInfo()]
    @State var textField = ""
    @State var coords = [Coord(),Coord()]
    @State var coordinates = Coord()
    @State var counter = 0
    @State var isPresented = false
    @State var cancellables = Set<AnyCancellable>()
    @StateObject var vm = WeatherViewModel()
    
    var body: some View {
        NavigationStack{
            VStack {
                ForEach(0..<currentWeather.count, id: \.self) { weather in
                    WeatherView(weather: $currentWeather[weather])
                }
                WeatherView(weather: $vm.currentWeatherCombine)
                Spacer()
                Button {
                    
                    getWeatherHandler(coord: coords[0]) { weather, error in
                     if let newWeather = weather {
                         currentWeather[0] = newWeather
                        }
                     }
                    
                    
                    Task {
                        currentWeather[1] = try await getWeatherAsync(coord: coordinates) ?? WeatherInfo()
                    }
                    
                    /*getWeatherCombine(coord: coords[2])
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .failure(let err) :
                                print(err.localizedDescription)
                            case .finished :
                                print("Finished")
                            }
                        }, receiveValue: { newWeather in
                            currentWeather[2] = newWeather
                        })
                        .store(in: &cancellables)*/
                    vm.getWeatherCombine(coord: coords[1])
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.blue)
                            .frame(width: 250, height: 100)
                        HStack{
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.white)
                            Text("Update View")
                                .foregroundColor(.white)
                        }.font(.title2)
                    }
                }
            }
        }
        .searchable(text: $textField)
        .onSubmit(of: .search) {
            if counter == 0{
                Task{
                    coords[0] = await getCoords(name:textField) ?? Coord()
                }
                counter = (counter + 1) % 3
                
            } else if counter == 1 {
                Task{
                    coords[1] = await getCoords(name:textField) ?? Coord()
                }
                counter = (counter + 1) % 3
            } else if counter == 2 {
                Task{
                    coordinates = await getCoords(name:textField) ?? Coord()
                }
                counter = (counter + 1) % 3
            }
            isPresented = true
        }
        .alert("Location set for \(counterCodes[counter]!) call", isPresented: $isPresented) {
            Button("OK", role: .cancel) { textField = "" }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
