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
        weather = [Weather()]
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
    var all: Int?
    
    init() {
        all = 0
    }
}

// MARK: - Coord
struct Coord: Codable {
    var lon, lat: Double?
    
    init() {
        lon = 0
        lat = 0
    }
}

// MARK: - Main
struct Main: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, humidity, seaLevel, grndLevel: Int?

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
    var the3H: Double?

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
    var country: String?
    var sunrise, sunset: Int?
    
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
    var id: Int?
    var main, description, icon: String?
    
    init() {
        id = 0
        main = ""
        description = ""
        icon = ""
    }
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
    var gust: Double?
    
    init() {
        speed = 0
        deg = 0
        gust = 0
    }
}

var icon = [
    200 : "cloud.bolt.rain",
    201 : "cloud.bolt.rain",
    202 : "cloud.bolt.rain",
    210 : "cloud.bolt.rain",
    211 : "cloud.bolt.rain",
    212 : "cloud.bolt.rain",
    221 : "cloud.bolt.rain",
    230 : "cloud.bolt.rain",
    231 : "cloud.bolt.rain",
    232 : "cloud.bolt.rain",
    300 : "cloud.drizzle",
    301 : "cloud.drizzle",
    302 : "cloud.drizzle",
    310 : "cloud.drizzle",
    311 : "cloud.drizzle",
    312 : "cloud.drizzle",
    313 : "cloud.drizzle",
    314 : "cloud.drizzle",
    321 : "cloud.drizzle",
    500 : "cloud.sun.rain",
    501 : "cloud.sun.rain",
    502 : "cloud.sun.rain",
    503 : "cloud.sun.rain",
    504 : "cloud.sun.rain",
    511 : "snowflake",
    520 : "cloud.heavyrain",
    521 : "cloud.heavyrain",
    522 : "cloud.heavyrain",
    531 : "cloud.heavyrain",
    600 : "snowflake",
    601 : "snowflake",
    602 : "snowflake",
    611 : "snowflake",
    612 : "snowflake",
    613 : "snowflake",
    614 : "snowflake",
    615 : "snowflake",
    616 : "snowflake",
    620 : "snowflake",
    621 : "snowflake",
    622 : "snowflake",
    701 : "cloud.fog",
    711 : "cloud.fog",
    721 : "cloud.fog",
    731 : "cloud.fog",
    741 : "cloud.fog",
    751 : "cloud.fog",
    761 : "cloud.fog",
    762 : "cloud.fog",
    771 : "cloud.fog",
    781 : "tornado",
    800 : "sun.min",
    801 : "cloud.sun",
    802 : "cloud",
    803 : "cloud.sun",
    804 : "cloud.sun"
]
