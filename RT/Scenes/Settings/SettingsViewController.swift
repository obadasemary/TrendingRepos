//
//  SettingsViewController.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 19.05.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - @IBOutlet

    @IBOutlet weak var darkModeSwitchControl: UISwitch!
    @IBOutlet weak var errorModeSwitchControl: UISwitch!

    let defaults = UserDefaults.standard

    var viewModel: SettingsViewModelType

    init(viewModel: SettingsViewModelType = SettingsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: "SettingsViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureControllers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.prefersLargeTitles = false
    }

    func configureControllers() {
        title =  "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem?.tintColor = .black
        darkModeSwitchControl.isOn = defaults.bool(forKey: "darkModePreference")
        errorModeSwitchControl.isOn = defaults.bool(forKey: "errorModePreference")
    }

    @IBAction func didTapDarkModeSwitch(_ sender: UISwitch) {
        viewModel.updateDarkModeSwitch(sender.isOn)
    }

    @IBAction func didTapErrorModeSwitch(_ sender: UISwitch) {
        viewModel.updateErrorModeSwitch(sender.isOn)
    }
}
