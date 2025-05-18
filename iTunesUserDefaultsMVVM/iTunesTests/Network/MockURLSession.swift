//
//  MockURLSession.swift
//  iTunesTests
//
//  Created by Ибрагим Габибли on 28.04.2025.
//

import Foundation
@testable import iTunesUserDefaultsMVVM

final class MockURLSession: URLSessionProtocol {
    private(set) var dataTaskCallCount = 0
    private(set) var dataTaskCallArgsUrl = [URL]()
    private(set) var dataTaskCallArgsCompletionHandler = [(Data?, URLResponse?, Error?) -> Void]()

    var data: Data?
    var response: URLResponse?
    var error: Error?

    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        dataTaskCallCount += 1
        dataTaskCallArgsUrl.append(url)
        dataTaskCallArgsCompletionHandler.append(completionHandler)

        return MockURLSessionDataTask {
            let completion = self.dataTaskCallArgsCompletionHandler.last!
            completion(self.data, self.response, self.error)
        }
    }
}

