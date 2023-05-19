//
//  MockAPIService.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 17.05.2023.
//

import Foundation
@testable import RT

struct MockSuccessAPIService: APIServiceProtocol {

    func fetchTrendingRepos(completionHandler: @escaping (Result<[TrendingRepo], NetworkError>) -> Void) {
        completionHandler(.success(TrendingRepos.stub.items))
    }
}

struct MockFailureAPIService: APIServiceProtocol {

    func fetchTrendingRepos(completionHandler: @escaping (Result<[TrendingRepo], NetworkError>) -> Void) {
        completionHandler(.failure(.noDataFound))
    }
}
