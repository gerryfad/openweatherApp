//
//  WeatherApi.swift
//  openweatherApp
//
//  Created by Gerry on 03/03/25.
//

import RxSwift

struct WeatherApi {
    
    static func getCurrentWeather(lat: Double, lon: Double) -> Observable<WeatherResponse> {
        return APIManager.shared.request(
            path: "/weather",
            method: .get,
            parameters: ["lat": lat, "lon": lon, "appid" : "afeaeb26448e381c057a46a73f9a8a32"]
        )
    }
    
    static func getForecastData(lat: Double, lon: Double) -> Observable<ForeCast> {
        return APIManager.shared.request(
            path: "/forecast",
            method: .get,
            parameters: ["cnt": 8,"units": "metric", "lat": lat, "lon": lon, "appid" : "afeaeb26448e381c057a46a73f9a8a32"]
        )
    }
    
}
