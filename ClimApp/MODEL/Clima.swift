//
//  Clima.swift
//  ClimApp
//
//  Created by Ivan on 16/11/2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

// MARK: - ClimaResponse
struct ClimaResponse: Codable {
    let hourly: [Current]
    let current: Current
    let timezoneOffset: Int
    let daily: [Daily]
    let lon: Double
    let timezone: String
    let minutely: [Minutely]
    let lat: Double

    enum CodingKeys: String, CodingKey {
        case hourly, current
        case timezoneOffset = "timezone_offset"
        case daily, lon, timezone, minutely, lat
    }
}

// MARK: - Current
struct Current: Codable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let sunrise, sunset: Int?
    let uvi: Double?
    let windDeg: Int
    let weather: [Weather]
    let feelsLike: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let pressure: Int
    let dewPoint: Double
    let pop: Int?

    enum CodingKeys: String, CodingKey {
        case dt, temp, humidity, sunrise, sunset, uvi
        case windDeg = "wind_deg"
        case weather
        case feelsLike = "feels_like"
        case clouds, visibility
        case windSpeed = "wind_speed"
        case pressure
        case dewPoint = "dew_point"
        case pop
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: Main
    let icon: Icon
    let weatherDescription: Description

    enum CodingKeys: String, CodingKey {
        case id, main, icon
        case weatherDescription = "description"
    }
}

enum Icon: String, Codable {
    case the01D = "01d"
    case the01N = "01n"
    case the02D = "02d"
    case the03D = "03d"
    case the04D = "04d"
    case the04N = "04n"
    case the10D = "10d"
}

enum Main: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

enum Description: String, Codable {
    case algoDeNubes = "algo de nubes"
    case cieloClaro = "cielo claro"
    case lluviaLigera = "lluvia ligera"
    case lluviaModerada = "lluvia moderada"
    case muyNuboso = "muy nuboso"
    case nubes = "nubes"
    case nubesDispersas = "nubes dispersas"
}

// MARK: - Daily
struct Daily: Codable {
    let dt: Int
    let temp: Temp
    let humidity, sunrise, sunset: Int
    let uvi: Double
    let windDeg: Int
    let weather: [Weather]
    let feelsLike: FeelsLike
    let clouds: Int
    let windSpeed: Double
    let pressure: Int
    let dewPoint, pop: Double
    let rain: Double?

    enum CodingKeys: String, CodingKey {
        case dt, temp, humidity, sunrise, sunset, uvi
        case windDeg = "wind_deg"
        case weather
        case feelsLike = "feels_like"
        case clouds
        case windSpeed = "wind_speed"
        case pressure
        case dewPoint = "dew_point"
        case pop, rain
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let night, eve, day, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let night, min, eve, day: Double
    let max, morn: Double
}

// MARK: - Minutely
struct Minutely: Codable {
    let dt, precipitation: Int
}
