//
//  ITunesServiceTest.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 18.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVVM

final class ITunesServiceTest: XCTestCase {
    private var service: ITunesService!
    private var mockURLSession: MockURLSession!
    private var mockDispatchQueue: MockDispatchQueue!

    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        mockDispatchQueue = MockDispatchQueue()
        service = ITunesService(
            urlSession: mockURLSession,
            dispatchQueue: mockDispatchQueue
        )
    }

    override func tearDown() {
        service = nil
        mockURLSession = nil
        mockDispatchQueue = nil
        super.tearDown()
    }

    func testGivenValidResponse_WhenLoadAlbums_ThenReturnsAlbumsArray() {
        // Given
        let mockJSON = """
        {
            "results": [
                {
                    "artistId": 111051,
                    "artistName": "Eminem",
                    "collectionName": "The Eminem Show",
                    "artworkUrl100": "url_to_image",
                    "collectionPrice": 10.99
                },
                {
                    "artistId": 20044,
                    "artistName": "Eminem",
                    "collectionName": "Levitating",
                    "artworkUrl100": "url_to_image",
                    "collectionPrice": 9.99
                }
            ]
        }
        """

        mockURLSession.data = mockJSON.data(using: .utf8)
        mockURLSession.error = nil

        // When
        service.loadAlbums(albumName: "Eminem") { result in
            // Then
            switch result {
            case .success(let albums):
                XCTAssertEqual(albums.count, 2)
                XCTAssertEqual(albums[0].collectionName, "The Eminem Show")
                XCTAssertEqual(albums[1].collectionName, "Levitating")
            case .failure:
                XCTFail("Expected success, got failure instead")
            }
        }
    }

    func testGivenNoData_WhenLoadAlbums_ThenReturnsNoDataError() {
        // Given
        mockURLSession.data = nil
        mockURLSession.error = nil

        // When
        service.loadAlbums(albumName: "Eminem") { result in
            // Then
            switch result {
            case .success:
                XCTFail("Should fail with no data")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.noData)
            }
        }
    }

    func testGivenInvalidData_WhenLoadAlbums_ThenReturnsDecodingError() {
        // Given
        mockURLSession.data = Data()
        mockURLSession.error = nil

        // When
        service.loadAlbums(albumName: "Eminem") { result in
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertTrue(error is DecodingError, "Expected a decoding error")
            }
        }
    }

    func testGivenSessionError_WhenLoadAlbum_ThenReturnsError() {
        // Given
        mockURLSession.data = nil
        mockURLSession.error = NSError(domain: "", code: -1, userInfo: nil)
        let expectation = expectation(description: "Failure completion called")

        // When
        service.loadAlbums(albumName: "Eminem") { result in
            // Then
            switch result {
            case .success:
                XCTFail("Should fail with error from session")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
