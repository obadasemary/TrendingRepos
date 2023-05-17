//
//  OwnerStub.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 17.05.2023.
//

import Foundation
@testable import RT

extension Owner {

    static let stub: Owner = .init(
        login: "apple",
        avatarUrl: "https://avatars.githubusercontent.com/u/10639145?v=4"
    )
}
