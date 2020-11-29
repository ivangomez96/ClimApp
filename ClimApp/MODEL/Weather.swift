//
//  Clima.swift
//  ClimApp
//
//  Created by Ivan on 16/11/2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

// MARK: - ClimaResponse
struct WeatherResponse: Codable {
    let hourly: [Current]
    let current: Current
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case hourly, current
        case daily
    }
}

// MARK: - Current
struct Current: Codable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let sunrise, sunset: Int?
    let weather: [Weather]
    let feelsLike: Double
    let clouds: Int
    let pop: Double?
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, temp, humidity, sunrise, sunset
        case weather
        case feelsLike = "feels_like"
        case clouds
        case pop, rain
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: Main
    let icon: String
    let weatherDescription: Description

    enum CodingKeys: String, CodingKey {
        case id, main, icon
        case weatherDescription = "description"
    }
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

