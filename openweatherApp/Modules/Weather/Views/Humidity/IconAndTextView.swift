//
//  IconAndTextView.swift
//  openweatherApp
//
//  Created by Gerry on 05/03/25.
//

import UIKit

class IconAndTextView: UIView {
    
    let spacer = UIView()
    
    private lazy var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        return imageView
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
        containerView.addArrangedSubViews(views: [icon,labelTitle,spacer])
    }
    
    func setData(label: String, icon: String) {
        self.labelTitle.text = label
        self.icon.image = UIImage(systemName: icon)
    }
}
