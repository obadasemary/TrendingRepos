//
//  TrendingReposTests.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 17.05.2023.
//

import XCTest
@testable import RT

final class TrendingReposTests: XCTestCase {

    func test_WhenInit_ThenDataReturn() {

        let sut = TrendingRepos.stub
        let item = sut.items.first

        XCTAssertEqual(sut.items.count, 1)
        XCTAssertEqual(item?.name, TrendingRepos.stub.items.first?.name)
        XCTAssertEqual(item?.description, TrendingRepos.stub.items.first?.description)
        XCTAssertEqual(item?.language, TrendingRepos.stub.items.first?.language)
        XCTAssertEqual(item?.starCount, TrendingRepos.stub.items.first?.starCount)
        XCTAssertEqual(item?.owner, TrendingRepos.stub.items.first?.owner)
    }

    func testTrendingReposDecoding() throws {
        let json = """
            {
                "items": [
                    {
                        "name": "Repo 1",
                        "description": "Description 1",
                        "language": "Swift",
                        "stargazers_count": 100,
                        "owner": {
                            "login": "John",
                            "avatar_url": "https://example.com/avatar1.png"
                        }
                    },
                    {
                        "name": "Repo 2",
                        "description": "Description 2",
                        "language": "Java",
                        "stargazers_count": 200,
                        "owner": {
                            "login": "Jane",
                            "avatar_url": "https://example.com/avatar2.png"
                        }
                    }
                ]
            }
            """

        let jsonData = Data(json.utf8)

        let decoder = JSONDecoder()
        let trendingRepos = try decoder.decode(TrendingRepos.self, from: jsonData)

        XCTAssertEqual(trendingRepos.items.count, 2, "Expected two items in TrendingRepos")
        XCTAssertEqual(trendingRepos.items[0].name, "Repo 1", "Expected correct name for the first TrendingRepo")
        XCTAssertEqual(
            trendingRepos.items[1].owner.login,
            "Jane",
            "Expected correct owner login for the second TrendingRepo"
        )
    }
}
