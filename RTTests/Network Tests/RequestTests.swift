//
//  RequestTests.swift
//  RTTests
//
//  Created by Abdelrahman Mohamed on 15.05.2023.
//

import XCTest
@testable import RT

final class RequestTests: XCTestCase {

    var sut: RequestStub!

    override func setUpWithError() throws {

        sut = RequestStub.acceptableEndPoint
    }

    override func tearDown() async throws {

        sut = nil
    }

    func test_WhenAcceptableEndPointProvided_ThenUrlNotNil() {

        sut = .acceptableEndPoint

        let request = sut.creatUrlRequest()

        XCTAssertNotNil(request)
    }

    func test_WhenUnAcceptableEndPointProvided_ThenUrlIsNil() {

        sut = .unAcceptableEndPoint

        let requset = sut.creatUrlRequest()

        XCTAssertNil(requset)
    }

    func test_WhenUnAcceptableEndPointProvided_ThenCreatUrl() {

        sut = .acceptableEndPoint

        let request = sut.creatUrlRequest()
        guard let url = request?.url else { return }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)

        XCTAssertEqual(urlComponents?.host, Constants.baseUrl.rawValue)
        XCTAssertEqual(urlComponents?.path, Constants.knownPath.rawValue)
        XCTAssertEqual(request?.httpMethod, RequestType.get.rawValue)
    }
}
