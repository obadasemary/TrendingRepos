//
//  APIServiceProtocol.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 16.05.2023.
//

import Foundation

protocol APIServiceProtocol {
    func fetchTrendingRepos(
        completionHandler: @escaping (Result<[TrendingRepo], NetworkError>) -> Void
    )
}
