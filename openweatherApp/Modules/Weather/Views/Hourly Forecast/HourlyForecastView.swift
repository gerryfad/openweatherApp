//
//  hourlyForecastView.swift
//  openweatherApp
//
//  Created by Gerry on 05/03/25.
//

import UIKit

class HourlyForecastView: UIView {
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setpadding(padding: .init(top: 14, left: 0, bottom: 0, right: 0))
        return view
    }()
        
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(HourlyForecastCell.self, forCellWithReuseIdentifier: HourlyForecastCell.cellIdentifier)
        return collectionView
    }()
    
    private lazy var labelTitleIcon: IconAndTextView = {
        let view = IconAndTextView()
        view.setData(label: "Hourly forecast", icon: "calendar")
        return view
    }()
    
    var items: ForeCast?
        
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        NSLayoutConstraint.addSubviewAndCreateArroundEqualConstraint(in: containerView, toView: self)
        containerView.addArrangedSubViews(views: [labelTitleIcon,collectionView])
    }
    
    func setData(data: ForeCast) {
        self.items = data
        collectionView.reloadData()
    }
}

extension HourlyForecastView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let forecastList = self.items?.list?.count
        return forecastList ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCell.cellIdentifier, for: indexPath) as! HourlyForecastCell
        if let forecastItem = self.items?.list?[indexPath.item] {
            
            let timeLabel = forecastItem.dt?.toTimeString() ?? "-"
            let tempLabel = "\(String(describing: Int(forecastItem.main?.temp ?? 0)))°C"
            let icon = forecastItem.weather?.first?.icon ?? "-"
            
            cell.setData(
                timeLabel: timeLabel,
                tempLabel: tempLabel,
                icon: icon)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 100)
    }
    
}
