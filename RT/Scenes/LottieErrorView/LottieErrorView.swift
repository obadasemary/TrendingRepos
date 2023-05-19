//
//  LottieErrorView.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 19.05.2023.
//

import UIKit
import Lottie

protocol LottieErrorDelegate: AnyObject {
    func didTapRetryButton()
}

class LottieErrorView: UIView {

    static let lottieErrorJson = "lottieError"

    weak var delegate: LottieErrorDelegate?

    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subitleLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.font = .boldSystemFont(ofSize: 18)
        subitleLabel.font = .systemFont(ofSize: 12)
        subitleLabel.textColor = .secondaryLabel
        retryButton.layer.cornerRadius = 8
        retryButton.layer.borderWidth = 2
        retryButton.layer.borderColor = UIColor.systemGreen.cgColor

        animationView.animation = .named(LottieErrorView.lottieErrorJson)
        animationView.loopMode = .loop
        animationView.play()
    }

    @IBAction func didTapRetryButton(_ sender: Any) {
        delegate?.didTapRetryButton()
    }
}
