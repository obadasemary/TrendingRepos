//
//  RequestStub.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 15.05.2023.
//

import Foundation
@testable import RT

enum RequestStub {
    case unAcceptableEndPoint
    case acceptableEndPoint
}

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum Constants: String {
    case baseUrl = "apple.com"
    case unknownDomain
    case knownPath = "/v1"
    case unknownPath
    case header
    case urlParameters
}

extension RequestStub: RequestProtocol {

    var baseUrl: String {
        switch self {
        case .acceptableEndPoint:
            return Constants.baseUrl.rawValue
        case .unAcceptableEndPoint:
            return Constants.unknownDomain.rawValue
        }
    }

    var path: String {
        switch self {
        case .acceptableEndPoint:
            return Constants.knownPath.rawValue
        case .unAcceptableEndPoint:
            return Constants.unknownPath.rawValue
        }
    }

    var requestType: RT.RequestType {
        switch self {
        case .acceptableEndPoint:
            return .get
        case .unAcceptableEndPoint:
            return .get
        }
    }

    var requestHeader: [String: String]? {
        switch self {
        case .acceptableEndPoint:
            return [Constants.header.rawValue: Constants.header.rawValue]
        case .unAcceptableEndPoint:
            return nil
        }
    }

    var urlParameters: [String: Any?]? {
        switch self {
        case .acceptableEndPoint:
            return [Constants.urlParameters.rawValue: Constants.urlParameters.rawValue]
        case .unAcceptableEndPoint:
            return nil
        }
    }
}
