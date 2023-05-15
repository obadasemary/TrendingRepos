//
//  CoordinatorTests.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 15.05.2023.
//

import XCTest
@testable import RT

final class CoordinatorTests: XCTestCase {

    func test_WhenSetRootVC_ThenRootVCIsTrendingRepoVC() {

        let navigationController = UINavigationController()

        let sut = MainCoordinator(navigationController)
        sut.setRootViewController()

        XCTAssertTrue(sut.navigationController.viewControllers.first is TrendingRepoViewController)
    }
}
