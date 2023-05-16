//
//  GithubRequest.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 16.05.2023.
//

import Foundation

enum GithubRequest {
    case searchRepository
}

extension GithubRequest: RequestProtocol {

    var path: String {
        switch self {
        case .searchRepository:
            return "/search/repositories"
        }
    }

    var requestType: RequestType {
        .get
    }

    var headers: [String: String]? {
        nil
    }

    var urlParams: [String: String?]? {
        ["q": "language=+sort:stars"]
    }
}
