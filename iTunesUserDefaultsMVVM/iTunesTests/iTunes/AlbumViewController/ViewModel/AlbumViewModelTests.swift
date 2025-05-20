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

    func test_GivenViewModel_WhenInitialized_ThenAlbumNameIsSetCorrectly() {
        // Given
        let expectedAlbumName = mockAlbum.collectionName

        // When
        let actualAlbumName = viewModel.albumName.value

        // Then
        XCTAssertEqual(actualAlbumName, expectedAlbumName)
    }

    func test_GivenViewModel_WhenInitialized_ThenArtistNameIsSetCorrectly() {
        // Given
        let expectedArtistName = mockAlbum.artistName

        // When
        let actualArtistName = viewModel.artistName.value

        // Then
        XCTAssertEqual(actualArtistName, expectedArtistName)
    }

    func test_GivenViewModel_WhenInitialized_ThenCollectionPriceIsSetCorrectly() {
        // Given
        let expectedCollectionPrice = "\(mockAlbum.collectionPrice) $"

        // When
        let actualCollectionPrice = viewModel.collectionPrice.value

        // Then
        XCTAssertEqual(actualCollectionPrice, expectedCollectionPrice)
    }

    func test_GivenImageLoaderReturnsImage_WhenViewModelLoadsImage_ThenAlbumImageIsSet() {
        // Given
        let expectedImage = UIImage(systemName: "checkmark.diamond")
        mockImageLoader.mockImage = expectedImage

        // When
        viewModel = AlbumViewModel(imageLoader: mockImageLoader, album: mockAlbum)
        waitForAsyncTasksToComplete()

        // Then
        XCTAssertEqual(viewModel.albumImage.value, expectedImage)
    }

    func test_GivenImageLoaderReturnsError_WhenViewModelLoadsImage_ThenAlbumImageIsNil() {
        // Given
        mockImageLoader.shouldReturnError = true

        // When
        viewModel = AlbumViewModel(imageLoader: mockImageLoader, album: mockAlbum)
        waitForAsyncTasksToComplete()

        // Then
        XCTAssertNil(viewModel.albumImage.value)
    }

    private func waitForAsyncTasksToComplete() {
        let expectation = expectation(description: "Waiting for async tasks")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
