//
//  ITunesServiceTest.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 18.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVVM

final class ITunesServiceTest: XCTestCase {
    private var service: MockITunesService!

    override func setUp() {
        super.setUp()
        service = MockITunesService()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testLoadAlbumsSuccess() {
        let albums = [
            Album(artistId: 111051,
                  artistName: "Eminem",
                  collectionName: "The Eminem Show",
                  artworkUrl100: "url_to_image",
                  collectionPrice: 10.99
                 ),
            Album(artistId: 20044,
                  artistName: "Eminem",
                  collectionName: "Levitating",
                  artworkUrl100: "url_to_image",
                  collectionPrice: 9.99
                 )
        ]

        service.result = .success(albums)

        service.loadAlbums(albumName: "Eminem") { result in
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

    func testGetCharactersFailure() {
        service.result = .failure(NetworkError.noData)

        service.loadAlbums(albumName: "Eminem") { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success instead")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.noData)
            }
        }
    }

    func testDecodingError() {
        service.loadAlbumsWithInvalidJSON(albumName: "Eminem") { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertTrue(error is DecodingError, "Expected a decoding error")
            }
        }
    }
}
