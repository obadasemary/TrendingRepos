//
//  GithubRequestTests.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 16.05.2023.
//

import XCTest
@testable import RT

final class GithubRequestTests: XCTestCase {

    func test_WhenGithubProvided_ThenCreateUrlRequest() {

        let sut = GithubRequest.searchRepository
        let urlRequest = sut.creatUrlRequest()
        let url = urlRequest?.url

        guard let url = url else {
            XCTAssertNil(url)
            return
        }

        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)

        XCTAssertEqual(urlComponents?.host, globalbaseURL)
        XCTAssertEqual(urlComponents?.path, "/search/repositories")
        XCTAssertNotNil(urlComponents?.queryItems)
        XCTAssertEqual(urlComponents?.queryItems?.count, 1)
        XCTAssertEqual(urlRequest?.httpMethod, RequestType.get.rawValue)
    }
}
