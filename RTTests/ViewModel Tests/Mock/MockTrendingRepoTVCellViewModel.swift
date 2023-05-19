//
//  MockTrendingRepoTVCellViewModel.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 19.05.2023.
//

import Foundation
@testable import RT

struct MockTrendingRepoTVCellViewModel: TrendingRepoTVCellViewModelType {

    var repoAvatarUrl: URL = URL(string: TrendingRepo.stub.owner.avatarUrl)!
    var repoName: String = TrendingRepo.stub.name
    var repoOwner: String = TrendingRepo.stub.owner.login
    var repoDescription: String = TrendingRepo.stub.description
    var repoLanguage: String = TrendingRepo.stub.language ?? ""
    var repoStarCount: String = "\(TrendingRepo.stub.starCount)"
}
