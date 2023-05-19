//
//  SceneDelegate.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 15.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?
    let defaults = UserDefaults.standard

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        defaults.removeObject(forKey: "errorModePreference")

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        mainCoordinator = MainCoordinator(navigationController)
        mainCoordinator?.setRootViewController()

        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = defaults.bool(forKey: "darkModePreference") ? .dark : .light
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
