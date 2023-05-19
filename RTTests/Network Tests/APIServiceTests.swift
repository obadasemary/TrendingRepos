//
//  APIServiceTests.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 17.05.2023.
//

import XCTest
@testable import RT

final class APIServiceTests: XCTestCase {

    func test_WhenEndPoindProvided_ThenFetchDataSuccessfully() {

        let expectation = expectation(description: "Success Expectation")
        let sut = APIService()

        sut.fetchTrendingRepos { result in

            expectation.fulfill()

            switch result {
            case.success(let trendingRepo):
                XCTAssertTrue(trendingRepo.count > 0)
            case .failure(let error):
                XCTFail("we have an error \(error) Unfortunately")
            }
        }

        waitForExpectations(timeout: 2.0)
    }

    func test_WhenEndPointProvidedWithRestAPI_ThenFetchDataSuccessfully() {

        let expectation = expectation(description: "Success Expectation")
        let sut = APIService()

        sut.fetchTrendingRepos { result in

            expectation.fulfill()

            switch result {
            case.success(let trendingRepo):
                XCTAssertTrue(trendingRepo.count > 0)
            case .failure(let error):
                XCTFail("we have an error \(error) Unfortunately")
            }
        }

        waitForExpectations(timeout: 2.0)
    }

    func test_WhenEndPointProvidedWithMockAPI_ThenFetchDataSuccessfully() {

        let expectation = expectation(description: "Success Expectation")
        let sut = MockSuccessAPIService()
        let stub = TrendingRepos.stub.items
        let repo = stub.first

        sut.fetchTrendingRepos { result in

            expectation.fulfill()

            switch result {
            case.success(let trendingRepo):

                XCTAssertTrue(trendingRepo.count > 0)

                let result = trendingRepo.first
                XCTAssertEqual(result?.name, repo?.name)
                XCTAssertEqual(result?.description, repo?.description)
                XCTAssertEqual(result?.language, repo?.language)
                XCTAssertEqual(result?.starCount, repo?.starCount)
                XCTAssertEqual(result?.owner, repo?.owner)
            case .failure(let error):
                XCTFail("we have an error \(error) Unfortunately")
            }
        }

        waitForExpectations(timeout: 2.0)
    }

    func test_WhenEndPointProvidedWithMockAPI_ThenFetchDataFailure() {

        let expectation = expectation(description: "Failure Expectation")
        let sut = MockFailureAPIService()

        sut.fetchTrendingRepos { result in

            expectation.fulfill()

            switch result {
            case.success(let trendingRepo):
                XCTFail("Fail if we have an error \(trendingRepo) Unfortunately")
            case .failure(let error):
                XCTAssertEqual(error, .noDataFound)
            }
        }

        waitForExpectations(timeout: 2.0)
    }
}
