//
//  TrendingRepoViewModel.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 16.05.2023.
//

import Foundation

protocol TrendingRepoViewModelType {

    var trendingRepos: [TrendingRepo] { get }
    func fetchTrendingRepositories(completionHanlder: @escaping ([TrendingRepo]?, NetworkError?) -> Void)
}

final class TrendingRepoViewModel: TrendingRepoViewModelType {

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
}
