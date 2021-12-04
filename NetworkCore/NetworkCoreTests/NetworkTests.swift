//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by Jade Silveira on 03/12/21.
//

import XCTest
@testable import NetworkCore

private final class SessionMock: SessionProtocol {
    var makeRequestUrlCompletionExpectedResult: (data: Data?, response: URLResponse?, error: Error?)?
    var makeRequestUrlRequestCompletionExpectedResult: (data: Data?, response: URLResponse?, error: Error?)?
    
    func makeRequest(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let expectedResult = makeRequestUrlCompletionExpectedResult else {
            XCTFail("Expected result was not defined.")
            return
        }
        completionHandler(expectedResult.data, expectedResult.response, expectedResult.error)
    }
    
    func makeRequest(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let expectedResult = makeRequestUrlRequestCompletionExpectedResult else {
            XCTFail("Expected result was not defined.")
            return
        }
        completionHandler(expectedResult.data, expectedResult.response, expectedResult.error)
    }
}

private final class DispatchQueueSpy: DispatchQueueProtocol {
    func callAsync(group: DispatchGroup?,
                   qos: DispatchQoS,
                   flags: DispatchWorkItemFlags,
                   execute work: @escaping () -> Void) {
        
    }
}

final class NetworkTests: XCTestCase {
    private let sessionMock = SessionMock()
    private let dispatchQueueSpy = DispatchQueueSpy()
    
    private lazy var sut: Network = {
        let network = Network(session: sessionMock, queue: dispatchQueueSpy)
        return network
    }()
}
