//
//  NSLayoutConstraintExtensions.swift
//  openweatherApp
//
//  Created by Gerry on 03/03/25.
//

import Foundation

import UIKit

extension NSLayoutConstraint {
    
    static func pinToSafeArea(_ view: UIView, toView: UIView, insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        if edges.contains(.left) {
            constraints += [view.leftAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.leftAnchor, constant: insets.left)]
        }
        if edges.contains(.top) {
            constraints += [view.topAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.topAnchor, constant: insets.top)]
        }
        if edges.contains(.right) {
            constraints += [view.rightAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.rightAnchor, constant: insets.right)]
        }
        if edges.contains(.bottom) {
            constraints += [view.bottomAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom)]
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
