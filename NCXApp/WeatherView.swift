//
//  WeatherView.swift
//  NCXApp
//
//  Created by Letterio Ugo Cangiano on 27/03/23.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        HStack{
            Spacer()
            VStack{
                Text("New York")
                    .font(.title)
                Text("30°")
                    .font(Font.system(size: 76))
            }
            Spacer()
            VStack{
                Image(systemName: "sun.min")
                    .font(Font.system(size: 76))
                Text("Clear")
                    .font(.italic(.title)())
            }
            Spacer()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
