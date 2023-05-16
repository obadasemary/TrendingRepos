//
//  APIService.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 16.05.2023.
//

import Foundation

struct APIService: APIServiceProtocol, APIManager {

    let urlSession: URLSessionProtocol
    let decoder: JSONDecoder

    init(
        urlSession: URLSessionProtocol = URLSession.shared,
        decoder: JSONDecoder = .init()
    ) {
        self.urlSession = urlSession
        self.decoder = decoder
    }

    func fetchTrendingRepos(completionHandler: @escaping (Result<[TrendingRepo], NetworkError>) -> Void) {

        perform(
            GithubRequest.searchRepository,
            urlSession: urlSession,
            responseModel: TrendingRepos.self,
            decoder: .init()
        ) { result in
            switch result {
            case .success(let trendingRepos):
                completionHandler(.success(trendingRepos.items))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
