//
//  AppFlowController.swift
//  TechnicalTest
//
//  Created by Marouene on 11/04/2023.
//

import UIKit


class AppFlowController: UINavigationController {
    private let diContainer = DIContainer.create()
 
    func start() {
        let homeVC = HomeViewController(
            homeViewModel: HomeViewModel(
                diContainer: diContainer
            )
        )
        homeVC.delegate = self
        viewControllers = [homeVC]
    }
}

extension AppFlowController: HomeViewProtocol {
    func homeView(viewController: HomeViewController, didSelect advertisement: RichAdvertisement) {
        let viewModel = AdvertisementDetailViewModel(advertisement: advertisement)
        let vc = AdvertisementDetailViewController(viewModel: viewModel)
        pushViewController(vc, animated: true)
    }
}
