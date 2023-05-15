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
}

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func setRootViewController() {
        let trendingRepoViewController = TrendingRepoViewController()
        self.navigationController.pushViewController(trendingRepoViewController, animated: false)
    }
}
