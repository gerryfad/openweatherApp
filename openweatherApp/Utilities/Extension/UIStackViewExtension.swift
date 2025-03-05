//
//  UIStackViewExtension.swift
//  openwatherApp
//
//  Created by Gerry on 03/03/25.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubViews(views: [UIView]) {
        views.forEach { (view) in
            self.addArrangedSubview(view)
        }
    }
    
    func setpadding(padding: UIEdgeInsets) {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = padding
    }
  
}
