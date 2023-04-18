//
//  File.swift
//  TechnicalTest
//
//  Created by Marouene on 15/04/2023.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, comment: "")
    }
}
