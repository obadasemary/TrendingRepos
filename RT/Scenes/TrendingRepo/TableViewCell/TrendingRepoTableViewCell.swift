//
//  TrendingRepoTableViewCell.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 17.05.2023.
//

import UIKit
import Kingfisher

class TrendingRepoTableViewCell: UITableViewCell {

    static let identifier = "TrendingRepoTableViewCell"

    @IBOutlet var repoImageView: UIImageView!
    @IBOutlet var repoOwnerLabel: UILabel!
    @IBOutlet var repoNameLabel: UILabel!
    @IBOutlet var repoDescriptionLabel: UILabel!
    @IBOutlet var repoLanguageLabel: UILabel!
    @IBOutlet var repoStartCountLabel: UILabel!
    @IBOutlet var repoLanguageView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        repoOwnerLabel.font = .systemFont(ofSize: 16)
        repoOwnerLabel.textColor = .label
        repoNameLabel.font = .boldSystemFont(ofSize: 20)
        repoNameLabel.textColor = .label
        repoDescriptionLabel.font = .systemFont(ofSize: 12)
        repoDescriptionLabel.textColor = .secondaryLabel
        repoDescriptionLabel.numberOfLines = 3
        repoLanguageLabel.font = .systemFont(ofSize: 12)
        repoLanguageLabel.textColor = .secondaryLabel
        repoStartCountLabel.font = .systemFont(ofSize: 12)
        repoStartCountLabel.textColor = .secondaryLabel
    }

    func configureRepoCell(with viewModel: TrendingRepoCellViewModelProtocol) {

        repoOwnerLabel.text = viewModel.repoOwner
        repoNameLabel.text = viewModel.repoName
        repoDescriptionLabel.text = viewModel.repoDescription
        repoLanguageLabel.text = viewModel.repoLanguage
        repoStartCountLabel.text = viewModel.repoStarCount
        repoImageView.kf.setImage(with: viewModel.repoAvatarUrl)
    }
}