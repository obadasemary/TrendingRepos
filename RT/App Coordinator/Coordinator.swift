//
//  Coordinator.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 15.05.2023.
//

import UIKit

protocol Coordinator: AnyObject {

    var navigationController: UINavigationController { get set }
    func setRootViewController()
    func goingToSettingsController()
}

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func setRootViewController() {
        let viewModel = TrendingRepoViewModel()
        let trendingRepoViewController = TrendingRepoViewController(viewModel: viewModel)
        viewModel.coordinator = self
        self.navigationController.pushViewController(trendingRepoViewController, animated: false)
    }

    func goingToSettingsController() {
        let viewModel = SettingsViewModel()
        let settingsViewController = SettingsViewController(viewModel: viewModel)
        self.navigationController.pushViewController(settingsViewController, animated: true)
    }
}
