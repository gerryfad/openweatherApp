//
//  Forecast.swift
//  openweatherApp
//
//  Created by Gerry on 05/03/25.
//

import Foundation

struct ForeCast: Decodable {
    let list: [ForeCastList]?
}

struct ForeCastList: Decodable {
    let dt: Int?
    let weather: [Weather]?
    let main: Main?
}

struct Main: Decodable {
    let humidity: Double?
    let temp: Double?
}
