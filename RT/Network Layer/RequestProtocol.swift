//
//  RequestProtocol.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 15.05.2023.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum UrlScheme: String {
    case https
}

protocol RequestProtocol {

    var baseUrl: String { get }
    var path: String { get }
    var requestType: RequestType { get }
    var requestHeader: [String: String]? { get }
    var urlParams: [String: Any?]? { get }
}

extension RequestProtocol {

    func creatUrlRequest() -> URLRequest? {

        guard let url = url() else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.allHTTPHeaderFields = requestHeader
        request.timeoutInterval = 5.0
        return request
    }

    private func url() -> URL? {

        var urlComponents = URLComponents()
        urlComponents.scheme = UrlScheme.https.rawValue
        urlComponents.host = baseUrl
        urlComponents.path = path
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { return nil }

        return url
    }

    var queryItems: [URLQueryItem]? {
        guard requestType == .get, let parameters = urlParams else { return nil }
        return parameters.map({ URLQueryItem(name: $0, value: "\($1 ?? "")") })
    }
}
