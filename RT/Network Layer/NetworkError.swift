//
//  NetworkError.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 16.05.2023.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case noDataFound
    case invalidResponse
    case invalidServerResponse
    case noFound(String?)
    case badRequest(String?)
    case serverError(String?)
    case decoding(String?)
    case unknown(String?)
    case corrupetData
}
