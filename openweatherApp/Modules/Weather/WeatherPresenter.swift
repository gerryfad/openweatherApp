//
//  WeatherPresenter.swift
//  openweatherApp
//
//  Created by Gerry on 06/03/25.
//

import RxSwift
import RxCocoa

protocol WeatherPresenterProtocol: AnyObject {
    func showData()
    func showLoading()
    func showError(error: Error)
}

class WeatherPresenter {
    
    private let disposeBag = DisposeBag()
    weak var delegate: WeatherPresenterProtocol?
    
    var dataForecast: ForeCast?
    var dataWeather: WeatherResponse?
    
    func refresh(lat: Double, lon: Double) {
        delegate?.showLoading()
        Observable.zip(
            getForecastData(lat: lat, lon: lon),
            getWeatherData(lat: lat, lon: lon)
        ).do(onNext: { [weak self] (forecastData, weatherData) in
            self?.dataWeather = weatherData
            self?.dataForecast = forecastData
            self?.delegate?.showData()
        }).do(onError: { [weak self] error in
            self?.delegate?.showError(error: error)
        })
            .subscribe()
            .disposed(by: disposeBag)
    }
        
    func getForecastData(lat: Double, lon: Double) -> Observable<ForeCast?> {
        WeatherApi
            .getForecastData(lat: lat, lon: lon)
            .map {
                return $0
            }
    }
    
    func getWeatherData(lat: Double, lon: Double) -> Observable<WeatherResponse?> {
        WeatherApi
            .getCurrentWeather(lat: lat, lon: lon)
            .map {
                return $0
            }
    }

}
