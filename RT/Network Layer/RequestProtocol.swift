//
//  RequestProtocol.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 15.05.2023.
//

import Foundation

var globalbaseURL = "api.github.com"

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
    var headers: [String: String]? { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?]? { get }
}

extension RequestProtocol {

    var baseUrl: String {
//        APIConstants.baseURL.rawValue
        globalbaseURL
    }

    var params: [String: Any] {
        [:]
    }

    var urlParams: [String: String?] { [:] }

    var headers: [String: String] {
        [:]
    }
}

extension RequestProtocol {

    func creatUrlRequest() -> URLRequest? {

        guard let url = url() else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.allHTTPHeaderFields = headers

        request.setValue(
            APIConstants.applicationJson.rawValue,
            forHTTPHeaderField: APIConstants.contentType.rawValue
        )

        if !params.isEmpty {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params)
            } catch {
                print(error.localizedDescription)
            }
        }

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
        guard requestType == .get, let urlParams = urlParams else { return nil }
        return urlParams.map({ URLQueryItem(name: $0, value: $1) })
    }
}
