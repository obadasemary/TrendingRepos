//
//  SettingsViewModel.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 19.05.2023.
//

import UIKit

protocol SettingsViewModelType {

    func updateDarkModeSwitch(_ sender: Bool)
    func updateErrorModeSwitch(_ sender: Bool)
}

class SettingsViewModel: SettingsViewModelType {

    let defaults = UserDefaults.standard

    func updateDarkModeSwitch(_ sender: Bool) {
        defaults.set(sender, forKey: "darkModePreference")
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = sender ? .dark : .light
        }
    }

    func updateErrorModeSwitch(_ sender: Bool) {
        defaults.set(sender, forKey: "errorModePreference")
        globalbaseURL = sender ? "badUrl" : "api.github.com"
    }
}
