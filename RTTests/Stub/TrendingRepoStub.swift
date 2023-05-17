//
//  TrendingRepoStub.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 17.05.2023.
//

import Foundation
@testable import RT

extension TrendingRepo {

    static let stub: TrendingRepo = .init(
        name: "Swift",
        description: "The Swift Programming Language",
        language: "C++",
        starCount: 62712,
        owner: Owner.stub
    )
}
