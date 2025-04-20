//
//  AlbumViewModelTests.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 20.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVVM

final class AlbumViewModelTests: XCTestCase {
    var viewModel: AlbumViewModel!
    var mockImageLoader: MockImageLoader!
    var mockAlbum: Album!

    override func setUp() {
        super.setUp()
        mockImageLoader = MockImageLoader()
        mockAlbum = Album(artistId: 111051,
                          artistName: "Eminem",
                          collectionName: "The Eminem Show",
                          artworkUrl100: "url_to_image",
                          collectionPrice: 10.99
        )
        viewModel = AlbumViewModel(imageLoader: mockImageLoader,
                                   album: mockAlbum
        )
    }

    override func tearDown() {
        viewModel = nil
        mockAlbum = nil
        mockImageLoader = nil
        super.tearDown()
    }

    func testAlbumNameIsSetCorrectly() {
        XCTAssertEqual(viewModel.albumName.value, mockAlbum.collectionName)
    }

    func testArtistNameIsSetCorrectly() {
        XCTAssertEqual(viewModel.artistName.value, mockAlbum.artistName)
    }

    func testCollectionPriceIsSetCorrectly() {
        XCTAssertEqual(viewModel.collectionPrice.value, "\(mockAlbum.collectionPrice) $")
    }

    func testAlbumImageOnSuccessLoadsImage() {
        let expectedImage = UIImage(systemName: "checkmark.diamond")

        mockImageLoader.mockImage = expectedImage
        viewModel = AlbumViewModel(imageLoader: mockImageLoader,
                                   album: mockAlbum
        )

        waitForAsyncTasksToComplete()

        XCTAssertEqual(self.viewModel.albumImage.value, expectedImage)

    }

    func testAlbumImageOnErrorReturnsNil() {
        mockImageLoader.shouldReturnError = true

        waitForAsyncTasksToComplete()

        XCTAssertNil(self.viewModel.albumImage.value)
    }

    private func waitForAsyncTasksToComplete() {
        let expectation = expectation(description: "Waiting for async tasks")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
