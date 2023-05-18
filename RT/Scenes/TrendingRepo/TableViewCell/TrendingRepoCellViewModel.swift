//
//  TrendingRepoCellViewModel.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 17.05.2023.
//

import Foundation

protocol TrendingRepoTableViewCellViewModelProtocol {

    var repoAvatarUrl: URL { get }
    var repoName: String { get }
    var repoOwner: String { get }
    var repoDescription: String { get }
    var repoLanguage: String { get }
    var repoStarCount: String { get }
}

class TrendingRepoCellViewModel: TrendingRepoTableViewCellViewModelProtocol {

    var repoAvatarUrl: URL
    var repoName: String
    var repoOwner: String
    var repoDescription: String
    var repoLanguage: String
    var repoStarCount: String

    init(
        repoAvatarUrl: URL,
        repoName: String,
        repoOwner: String,
        repoDescription: String,
        repoLanguage: String,
        repoStarCount: String
    ) {
        self.repoAvatarUrl = repoAvatarUrl
        self.repoName = repoName
        self.repoOwner = repoOwner
        self.repoDescription = repoDescription
        self.repoLanguage = repoLanguage
        self.repoStarCount = repoStarCount
    }
}
