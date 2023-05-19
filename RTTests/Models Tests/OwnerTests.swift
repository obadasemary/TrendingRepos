//
//  OwnerTests.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 17.05.2023.
//

import XCTest
@testable import RT

final class OwnerTests: XCTestCase {

    func testWhenInit_ThenDataRetrun() {

        let sut = Owner.stub

        XCTAssertEqual(sut.login, Owner.stub.login)
        XCTAssertEqual(sut.avatarUrl, Owner.stub.avatarUrl)
    }

}
