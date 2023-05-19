//
//  MockFailureTrendingRepoViewModel.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 19.05.2023.
//

import Foundation
@testable import RT

class MockFailureTrendingRepoViewModel: TrendingRepoViewModelType {

    var trendingRepos: [TrendingRepo] = []

    func fetchTrendingRepositories(completionHanlder: @escaping ([TrendingRepo]?) -> Void) {
        completionHanlder(nil)
    }

    func makeTrendingRepositoriesCellViewModel(at index: Int) -> TrendingRepoTVCellViewModelType {
        return MockTrendingRepoTVCellViewModel()
    }

    func goToSettings() {}
}
