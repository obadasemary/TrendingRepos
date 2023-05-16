//
//  TrendingRepo.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 16.05.2023.
//

import Foundation

struct TrendingRepo: Hashable, Decodable {

    let identifier = UUID()
    let name: String
    let description: String
    let language: String?
    let starCount: Int
    let owner: Owner

    init(
        name: String,
        description: String,
        language: String?,
        starCount: Int,
        owner: Owner
    ) {
        self.name = name
        self.description = description
        self.language = language
        self.starCount = starCount
        self.owner = owner
    }

    enum CodingKeys: String, CodingKey {
        case name, owner, language, description
        case starCount = "stargazers_count"
    }

    static func == (lhs: TrendingRepo, rhs: TrendingRepo) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
