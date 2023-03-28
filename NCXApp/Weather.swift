//
//  Weather.swift
//  NCXApp
//
//  Created by Letterio Ugo Cangiano on 23/03/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherInfo = try? JSONDecoder().decode(WeatherInfo.self, from: jsonData)

import Foundation

// MARK: - WeatherInfo
struct WeatherInfo: Codable {
    var coord: Coord
    var weather: [Weather]
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var rain, snow: Rain?
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var timezone, id: Int
    var name: String
    var cod: Int
    
    init() {
        coord = Coord()
        weather = []
        base = ""
        main = Main()
        visibility = 0
        wind = Wind()
        clouds = Clouds()
        dt = 0
        sys = Sys()
        timezone = 0
        id = 0
        name = ""
        cod = 0
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int
    
    init() {
        all = 0
    }
}

// MARK: - Coord
struct Coord: Codable {
    var lon, lat: Double
    
    init() {
        lon = 0
        lat = 0
    }
}

// MARK: - Main
struct Main: Codable {
    var temp, feelsLike, tempMin, tempMax: Double
    var pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
    
    init() {
        temp = 0
        feelsLike = 0
        tempMin = 0
        tempMax = 0
        pressure = 0
        humidity = 0
        seaLevel = 0
        grndLevel = 0
    }
}

// MARK: - Rain
struct Rain: Codable {
    var the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
    
    init() {
        the3H = 0
    }
}

// MARK: - Sys
struct Sys: Codable {
    var type, id: Int?
    var country: String
    var sunrise, sunset: Int
    
    init() {
        type = 0
        id = 0
        country = ""
        sunrise = 0
        sunset = 0
    }
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int
    var main, description, icon: String
    
    init() {
        id = 0
        main = ""
        description = ""
        icon = ""
    }
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double
    var deg: Int
    var gust: Double
    
    init() {
        speed = 0
        deg = 0
        gust = 0
    }
}
