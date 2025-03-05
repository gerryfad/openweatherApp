//
//  WeatherViewController.swift
//  openweatherApp
//
//  Created by Gerry on 06/03/25.
//

import UIKit
import Kingfisher
import RxSwift
import XLPagerTabStrip
import CoreLocation
import MBProgressHUD

class WeatherViewController: UIViewController{
    
    private let locationManager = CLLocationManager()
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.setpadding(padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        view.isHidden = true
        return view
    }()
    
    private lazy var imageViewIcon: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = nil
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelCity: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .medium)
        return label
    }()
    
    private lazy var labelTemperature: UILabel = {
        let label = UILabel()
        label.text = "-° C"
        label.textColor = .white
        label.textAlignment = .center

        label.font = .systemFont(ofSize: 45, weight: .bold)
        return label
    }()
    
    private lazy var labelDesc: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .light)
        return label
    }()
    
    private lazy var forecastView: HourlyForecastView = {
        let view = HourlyForecastView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 150).isActive = true
        return view
    }()
    
    private lazy var humidityInfoView: HumidityInfoView = {
        let view = HumidityInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let presenter = WeatherPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupView()
        setupConstraint()
        
        locationManager.delegate = self
        locationManager.requestLocation()
        
        presenter.delegate = self

    }
    
    private func setupView() {
        self.view.addSubview(containerView)
        containerView.addArrangedSubViews(views: [labelCity,imageViewIcon,labelTemperature ,labelDesc,humidityInfoView,forecastView])
        
    }
    
    private func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg")
        backgroundImage.contentMode = .scaleAspectFill
        
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.pinToSafeArea(containerView, toView: self.view, edges: [.left, .right])
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])

    }
    
    private func setDataWeather(city: String, desc: String, temp: String, icon: String) {
        labelCity.text = city
        labelDesc.text = desc
        labelTemperature.text = "\(temp)° C"
        
        let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@4x.png")
        imageViewIcon.kf.setImage(with: url)
    }

}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        presenter.refresh(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error retrieving location: \(error.localizedDescription)")
        
        /// incase tidak sengaja klik dont allow, maka tetap getdata dengan lokasi jakarta
        presenter.refresh(lat: -6.2088, lon: 106.8456)

    }
}

extension WeatherViewController: WeatherPresenterProtocol {
    
    func showData() {
        MBProgressHUD.hide(for: self.view, animated: true)
        containerView.isHidden = false
        guard let dataForecast = presenter.dataForecast, let dataWeather = presenter.dataWeather else { return }
        
        self.forecastView.setData(data: dataForecast)
        self.humidityInfoView.setData(
            labelHumidity: "\(String(describing: Int(dataWeather.main?.humidity ?? 0)))",
            labelWind: "\(String(describing: Int(dataWeather.wind?.speed ?? 0)))",
            labelClouds: "\(String(describing: Int(dataWeather.clouds?.all ?? 0)))")
        
        self.setDataWeather(
            city: dataWeather.name ?? "",
            desc: dataWeather.weather?.first?.description ?? "", 
            temp: "\(String(describing: Int(dataWeather.main?.temp ?? 0)))",
            icon: dataWeather.weather?.first?.icon ?? "")
        
    }
    
    func showLoading() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
        hud.isUserInteractionEnabled = false
    }
    
    func showError(error: any Error) {
        print(error.localizedDescription)
        MBProgressHUD.hide(for: self.view, animated: true)
        containerView.isHidden = false
    }
    
}
