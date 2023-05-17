//
//  TrendingRepoViewModel.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 16.05.2023.
//

import Foundation

protocol TrendingRepoViewModelProtocol {

    var trendingRepos: [TrendingRepo] { get }
    func fetchTrendingRepositories(completionHanlder: @escaping ([TrendingRepo]?, NetworkError?) -> Void)
    func makeTrendingRepositoriesCellViewModel(at index: Int) -> TrendingRepoCellViewModelProtocol
}

final class TrendingRepoViewModel: TrendingRepoViewModelProtocol {

    private(set) var trendingRepos: [TrendingRepo] = []

    var service: APIServiceProtocol

    init(
        service: APIServiceProtocol = APIService()
    ) {
        self.service = service
    }

    func fetchTrendingRepositories(completionHanlder: @escaping ([TrendingRepo]?, NetworkError?) -> Void) {

        service.fetchTrendingRepos { [weak self] result in
            switch result {
            case .success(let trendingRepos):
                self?.trendingRepos = trendingRepos.count > 0 ? trendingRepos : []
                completionHanlder(trendingRepos, nil)
            case .failure(let error):
                completionHanlder(nil, error)
            }
        }
    }

    func makeTrendingRepositoriesCellViewModel(at index: Int) -> TrendingRepoCellViewModelProtocol {

        let trendingRepo = trendingRepos[index]
        var avatarUrl: URL

        if URL(string: trendingRepo.owner.avatarUrl) != nil {
            avatarUrl = URL(string: trendingRepo.owner.avatarUrl)!
        } else {
            avatarUrl = URL(string: "")!
        }

        return TrendingRepoCellViewModel(
            repoAvatarUrl: avatarUrl,
            repoName: trendingRepo.name,
            repoOwner: trendingRepo.owner.login,
            repoDescription: trendingRepo.description,
            repoLanguage: trendingRepo.language ?? "",
            repoStarCount: "\(trendingRepo.starCount)"
        )
    }
}
