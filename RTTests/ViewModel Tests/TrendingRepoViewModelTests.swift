//
//  TrendingRepoViewModelTests.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 19.05.2023.
//

import XCTest
@testable import RT

final class TrendingRepoViewModelTests: XCTestCase {

    var sut: TrendingRepoViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()

        sut = TrendingRepoViewModel(service: MockSuccessAPIService())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_WhenInit_ThenResutCountEmpty() {

        let repo = sut.trendingRepos
        XCTAssertEqual(repo.count, 0)
    }

    func test_WhenFetchRepoWithSuccess_ThenReturnResut() {

        let expectation = expectation(description: "Success Expectation")
        let stub: [TrendingRepo] = TrendingRepos.stub.items
        var outputRepos: [TrendingRepo]?

        sut.fetchTrendingRepositories { repo in

            expectation.fulfill()
            outputRepos = repo
        }

        XCTAssertNotNil(outputRepos)
        XCTAssertEqual(stub, outputRepos)

        waitForExpectations(timeout: 2.0)
    }

    func test_WhenFetchRepoWithFailure_ThenReturnResutNil() {

        let service = MockFailureAPIService()
        let sut = TrendingRepoViewModel(service: service)
        let expectation = expectation(description: "Failure Expectation")
        var outputRepos: [TrendingRepo]?

        sut.fetchTrendingRepositories { repo in

            expectation.fulfill()
            outputRepos = repo
        }

        XCTAssertNil(outputRepos)

        waitForExpectations(timeout: 2.0)
    }

    func test_WhenMakeTrendingRepositoriesCellViewModel_ThenReturnTrendingRepoTVCellViewModel() {

        sut.fetchTrendingRepositories { _ in }

        let outputTrendingRepoTVCellViewModelType = sut.makeTrendingRepositoriesCellViewModel(at: 0)
        let mockTrendingRepoTVCellViewModel: MockTrendingRepoTVCellViewModel = .init()

        XCTAssertEqual(
            outputTrendingRepoTVCellViewModelType.repoAvatarUrl,
            mockTrendingRepoTVCellViewModel.repoAvatarUrl
        )
        XCTAssertEqual(
            outputTrendingRepoTVCellViewModelType.repoOwner,
            mockTrendingRepoTVCellViewModel.repoOwner
        )
        XCTAssertEqual(
            outputTrendingRepoTVCellViewModelType.repoName,
            mockTrendingRepoTVCellViewModel.repoName
        )

        XCTAssertEqual(
            outputTrendingRepoTVCellViewModelType.repoDescription,
            mockTrendingRepoTVCellViewModel.repoDescription
        )
        XCTAssertEqual(
            outputTrendingRepoTVCellViewModelType.repoLanguage,
            mockTrendingRepoTVCellViewModel.repoLanguage
        )
        XCTAssertEqual(
            outputTrendingRepoTVCellViewModelType.repoStarCount,
            mockTrendingRepoTVCellViewModel.repoStarCount
        )
    }
}
