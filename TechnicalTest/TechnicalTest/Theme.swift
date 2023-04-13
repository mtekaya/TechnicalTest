//
//  Theme.swift
//  TechnicalTest
//
//  Created by Marouene on 13/04/2023.
//

import UIKit

enum Theme {
    enum Color {
        static let backgroundColor = UIColor.white
        static let primaryColor = UIColor.orange
        static let secondaryColor = UIColor.black
        static let tertiaryColor = UIColor.darkGray
        static let quaternaryColor = UIColor.lightGray
        static let urgentColor = UIColor.init(red: 1, green: 216.0/255, blue: 177.0/255, alpha: 1)
    }
    
    enum Layout {
        static let generalHorizontalMargin: CGFloat = 16
        static let generalVerticalMargin: CGFloat = 10
        static let interItemVerticalSpacing: CGFloat = 10
        static let cornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
        static let itemWidth: CGFloat = 320
        static let itemHeight: CGFloat = 120
        static let listImageHeight: CGFloat = 100
        static let listImageWidth: CGFloat = 100

    }
}
