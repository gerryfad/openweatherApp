//
//  HourlyForecastCell.swift
//  openweatherApp
//
//  Created by Gerry on 05/03/25.
//

import UIKit

class HourlyForecastCell: UICollectionViewCell {
    static let cellIdentifier = "HourlyForecastCell"
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalCentering
        view.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.isLayoutMarginsRelativeArrangement = true
        view.setpadding(padding: .init(top: 6, left: 0, bottom: 6, right: 0))
        
        addSubview(view)
        NSLayoutConstraint.addSubviewAndCreateArroundEqualConstraint(in: view, toView: self)
        return view
    }()

    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        contentView.addSubview(timeLabel)
        contentView.addSubview(icon)
        contentView.addSubview(tempLabel)

        setupView()
        
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupView() {
        containerView.addArrangedSubViews(views: [timeLabel,icon,tempLabel])
    
    }
    
    func setData(timeLabel: String, tempLabel: String, icon: String) {
        self.timeLabel.text = timeLabel
        self.tempLabel.text = tempLabel
        
        let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@4x.png")
        self.icon.kf.setImage(with: url)
    }


}
