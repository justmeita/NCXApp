//
//  ContentView.swift
//  NCXApp
//
//  Created by Letterio Ugo Cangiano on 28/03/23.
//

import SwiftUI

struct ContentView: View {
    @State var currentWeather = [WeatherInfo(),WeatherInfo(),WeatherInfo()]
    @State var textField = ""
    @State var coords = [Coord(),Coord(),Coord()]
    @State var counter = 0
    @State var isPresented = false
    
    var body: some View {
        NavigationStack{
            VStack {
                ForEach(0..<currentWeather.count, id: \.self) { weather in
                    WeatherView(weather: $currentWeather[weather])
                }
                Spacer()
                Button {
                    
                    getWeatherHandler(coord: coords[1]) { weather, error in
                     if let newWeather = weather {
                     currentWeather[1] = newWeather
                        }
                     }
                    
                    
                    Task {
                        currentWeather[0] = try await getWeatherAsync(coord: coords[0]) ?? WeatherInfo()
                    }
                    
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
                    await getCoords(name:textField, coord: &coords[0])
                }
                counter = (counter + 1) % 2
                
            } else if counter == 1 {
                Task{
                    await getCoords(name:textField, coord: &coords[1])
                }
                counter = (counter + 1) % 2
            }
            isPresented = true
        }
        .alert("Set place nr.\(counter)", isPresented: $isPresented) {
            Button("OK", role: .cancel) { textField = "" }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
