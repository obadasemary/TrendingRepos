//
//  SettingsViewController.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 19.05.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var switchControl: UISwitch!

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.tintColor = .black
        switchControl.isOn = defaults.bool(forKey: "darkModePreference")
    }

    @IBAction func didTapSwitch(_ sender: UISwitch) {
        UIApplication.shared.windows.forEach { window in
            defaults.set(sender.isOn, forKey: "darkModePreference")
            window.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
        }
    }
}
