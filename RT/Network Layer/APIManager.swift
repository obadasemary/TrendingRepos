//
//  APIManager.swift
//  RT
//
//  Created by Abdelrahman Mohamed on 16.05.2023.
//

import Foundation

protocol APIManager {

    func perform<T: Decodable>(
        _ request: RequestProtocol,
        urlSession: URLSessionProtocol,
        responseModel: T.Type,
        decoder: JSONDecoder,
        completionHandler: @escaping (Result<T, NetworkError>) -> Void
    )
}

extension APIManager {

    @available(*, renamed: "perform(_:urlSession:responseModel:decoder:)")
    func perform<T: Decodable>(
        _ request: RequestProtocol,
        urlSession: URLSessionProtocol,
        responseModel: T.Type,
        decoder: JSONDecoder,
        completionHandler: @escaping (Result<T, NetworkError>) -> Void
    ) {

        guard let ulrRequest = request.creatUrlRequest() else {
            completionHandler(.failure(.invalidURL))
            return
        }

        let task = urlSession.dataTask(with: ulrRequest) { data, response, _ in

            guard let data = data else {
                completionHandler(.failure(.noDataFound))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidResponse))
                return
            }

            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? decoder.decode(responseModel, from: data) else {
                    completionHandler(.failure(.corrupetData))
                    return
                }
                completionHandler(.success(decodedResponse))
            case 404:
                completionHandler(.failure(.noFound("Not Found")))

            default:
                completionHandler(.failure(.unknown("Something Wrong")))
            }
        }
        task.resume()
    }

    func perform<T: Decodable>(
        _ request: RequestProtocol,
        urlSession: URLSessionProtocol,
        responseModel: T.Type,
        decoder: JSONDecoder
    ) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            perform(request, urlSession: urlSession, responseModel: responseModel, decoder: decoder) { result in
                continuation.resume(with: result)
            }
        }
    }

}
