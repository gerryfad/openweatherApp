//
//  HumidityInfoView.swift
//  openweatherApp
//
//  Created by Gerry on 05/03/25.
//

import UIKit

class HumidityInfoView: UIView {
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .equalCentering
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setpadding(padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        return view
    }()
    
    private lazy var labelHumidity: IconAndTextView = {
        let view = IconAndTextView()
        view.setData(label: "-", icon: "drop")
        return view
    }()
    
    private lazy var labelWind: IconAndTextView = {
        let view = IconAndTextView()
        view.setData(label: "-", icon: "wind")
        return view
    }()
    
    private lazy var labelClouds: IconAndTextView = {
        let view = IconAndTextView()
        view.setData(label: "-", icon: "cloud")
        return view
    }()
            
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
        containerView.addArrangedSubViews(views: [labelHumidity,labelWind,labelClouds])
    }
    
    func setData(labelHumidity: String, labelWind: String, labelClouds: String) {
        self.labelHumidity.labelTitle.text = "\(labelHumidity)%"
        self.labelWind.labelTitle.text = "\(labelWind)km"
        self.labelClouds.labelTitle.text = "\(labelClouds)%"
    }

}
