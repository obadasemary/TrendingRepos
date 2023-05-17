//
//  TrendingRepoTests.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 17.05.2023.
//

import XCTest
@testable import RT

final class TrendingRepoTests: XCTestCase {

    func test_WhenInit_ThenDataReturn() {

        let sut = TrendingRepo.stub

        XCTAssertEqual(sut.name, TrendingRepo.stub.name)
        XCTAssertEqual(sut.description, TrendingRepo.stub.description)
        XCTAssertEqual(sut.language, TrendingRepo.stub.language)
        XCTAssertEqual(sut.starCount, TrendingRepo.stub.starCount)
        XCTAssertEqual(sut.owner, TrendingRepo.stub.owner)
    }

    func test_WhenInitWithNilLanguage_ThenLanguageNilReturn() {

        let sut = makeSut(
            name: TrendingRepo.stub.name,
            description: TrendingRepo.stub.description,
            starCount: TrendingRepo.stub.starCount,
            owner: TrendingRepo.stub.owner
        )

        XCTAssertEqual(sut.name, TrendingRepo.stub.name)
        XCTAssertEqual(sut.description, TrendingRepo.stub.description)
        XCTAssertEqual(sut.starCount, TrendingRepo.stub.starCount)
        XCTAssertEqual(sut.owner, TrendingRepo.stub.owner)

        XCTAssertNil(sut.language)
    }

    func testTrendingRepoHashing() {
        let owner = Owner.stub
        let repo = TrendingRepo(
            name: "Repo",
            description: "Description",
            language: "Swift",
            starCount: 100,
            owner: owner
        )

        var hasher1 = Hasher()
        repo.hash(into: &hasher1)

        var hasher2 = Hasher()
        repo.hash(into: &hasher2)

        XCTAssertEqual(
            hasher1.finalize(),
            hasher2.finalize(),
            "Hash value for the same TrendingRepo instance should be equal"
        )
    }

    // MARK: - Helper method for making SUT
    func makeSut(
        name: String,
        description: String,
        language: String? = nil,
        starCount: Int,
        owner: Owner
    ) -> TrendingRepo {

        let repo = TrendingRepo(
            name: name,
            description: description,
            language: language,
            starCount: starCount,
            owner: owner
        )

        return repo
    }
}
