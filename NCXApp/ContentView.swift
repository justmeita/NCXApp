//
//  ContentView.swift
//  NCXApp
//
//  Created by Letterio Ugo Cangiano on 28/03/23.
//

import SwiftUI

struct ContentView: View {
    @State var currentWeather1 = WeatherInfo()
    @State var currentWeather2 = WeatherInfo()
    @State var currentWeather3 = WeatherInfo()
    
    var body: some View {
        VStack {
            Button {
               /* getWeatherHandler() { weather, error in
                    if let newWeather = weather {
                        currentWeather1 = newWeather
                        print(weather!.sys.country)
                    }
                }*/
                Task {
                    currentWeather1 = try await getWeatherAsync() ?? WeatherInfo()
                }
            } label: {
                Text("Press here to make request")
            }
            Text("\(currentWeather1.name)")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
