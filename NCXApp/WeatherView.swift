//
//  WeatherView.swift
//  NCXApp
//
//  Created by Letterio Ugo Cangiano on 27/03/23.
//

import SwiftUI

struct WeatherView: View {
    @Binding var weather: WeatherInfo
    var body: some View {
        if weather.name != "" {
            HStack{
                Spacer()
                VStack{
                    Text("\(weather.name)")
                        .font(.title)
                    Text("\(Int(weather.main.temp ?? 0))°")
                        .font(Font.system(size: 76))
                }
                .padding()
                Spacer()
                VStack{
                    Image(systemName: "\(icon[weather.weather[0].id ?? 800] ?? "sun.min")")
                        .font(Font.system(size: 76))
                    Text("\(weather.weather[0].main ?? "")")
                        .font(.italic(.title)())
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: .constant(WeatherInfo()))
    }
}
