//
//  Weather.swift
//  openweatherApp
//
//  Created by Gerry on 03/03/25.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Main?
    let weather: [Weather]?
    let wind: Wind?
    let clouds: Clouds?
    let name: String?
}

struct Weather: Decodable {
    let id: Int?
    let description: String?
    let icon: String?
    let main: String?
}

struct Wind: Decodable {
    let speed: Double?
}

struct Clouds: Decodable {
    let all: Int?
}
