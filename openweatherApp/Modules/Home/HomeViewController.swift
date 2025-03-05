//
//  HomeViewController.swift
//  openweatherApp
//
//  Created by Gerry on 05/03/25.
//

import UIKit
import XLPagerTabStrip

class HomeViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        configPagerTab()
        super.viewDidLoad()

        setupView()
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let weather = WeatherViewController()
        let profile = ProfileViewController()
        return [weather, profile]
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        buttonBarView.tintColor = .gray

        buttonBarView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonBarView.heightAnchor.constraint(equalToConstant: 50),
            
            containerView.topAnchor.constraint(equalTo: buttonBarView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configPagerTab() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = .black
        settings.style.selectedBarHeight = 2.5
        
    }
}
