//
//  AppFlowController.swift
//  TechnicalTest
//
//  Created by compte temporaire on 11/04/2023.
//

import UIKit

class AppFlowController: UINavigationController {
    let diContainer = DIContainer.create()
 
    func start() {
        let homeVM = HomeViewModel(diContainer: diContainer)
        let homeVC = HomeViewController(homeViewModel: homeVM)
        viewControllers = [homeVC]
    }
}
