//
//  UIViewExtension.swift
//  TechnicalTest
//
//  Created by Marouene on 14/04/2023.
//

import UIKit

extension UIView {
    func fit(_ container: UIView,
             _ top: CGFloat = 0.0,
             _ leading: CGFloat = 0.0,
             _ bottom: CGFloat = 0.0,
             _ trailing: CGFloat = 0.0) {
        let guide = container.safeAreaLayoutGuide
        topAnchor.constraint(equalTo: guide.topAnchor, constant: top).isActive = true
        bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: bottom).isActive = true
        leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: leading).isActive = true
        trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: trailing).isActive = true
    }
}
