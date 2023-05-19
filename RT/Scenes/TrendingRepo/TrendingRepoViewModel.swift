//
//  TrendingRepoViewModel.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 16.05.2023.
//

import Foundation

protocol TrendingRepoViewModelType {

    var trendingRepos: [TrendingRepo] { get }
    func fetchTrendingRepositories(completionHanlder: @escaping ([TrendingRepo]?) -> Void)
    func makeTrendingRepositoriesCellViewModel(at index: Int) -> TrendingRepoTVCellViewModelType
    func goToSettings()
}

final class TrendingRepoViewModel: TrendingRepoViewModelType {

    private(set) var trendingRepos: [TrendingRepo] = []
    var coordinator: Coordinator?

    var service: APIServiceProtocol

    init(
        service: APIServiceProtocol = APIService()
    ) {
        self.service = service
    }

    func fetchTrendingRepositories(completionHanlder: @escaping ([TrendingRepo]?) -> Void) {

        service.fetchTrendingRepos { [weak self] result in
            switch result {
            case .success(let trendingRepos):
                self?.trendingRepos = trendingRepos.count > 0 ? trendingRepos : []
                completionHanlder(trendingRepos)
            case .failure:
                completionHanlder(nil)
            }
        }
    }

    func makeTrendingRepositoriesCellViewModel(at index: Int) -> TrendingRepoTVCellViewModelType {

        let trendingRepo = trendingRepos[index]
        var avatarUrl: URL

        if URL(string: trendingRepo.owner.avatarUrl) != nil {
            avatarUrl = URL(string: trendingRepo.owner.avatarUrl)!
        } else {
            avatarUrl = URL(string: "")!
        }

        return TrendingRepoTVCellViewModel(
            repoAvatarUrl: avatarUrl,
            repoName: trendingRepo.name,
            repoOwner: trendingRepo.owner.login,
            repoDescription: trendingRepo.description,
            repoLanguage: trendingRepo.language ?? "",
            repoStarCount: "\(trendingRepo.starCount)"
        )
    }

    func goToSettings() {

        coordinator?.goingToSettingsController()
    }
}
