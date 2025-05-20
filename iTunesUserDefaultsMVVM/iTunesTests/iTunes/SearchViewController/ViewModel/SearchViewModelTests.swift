//
//  SearchViewModelTests.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 19.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVVM

final class SearchViewModelTests: XCTestCase {
    private var viewModel: SearchViewModel!
    private var mockITunesService: MockITunesService!
    private var mockStorageManager: MockStorageManager!

    override func setUp() {
        super.setUp()
        mockITunesService = MockITunesService()
        mockStorageManager = MockStorageManager()
        viewModel = SearchViewModel(iTunesService: mockITunesService,
                                    storageManager: mockStorageManager
        )
    }

    override func tearDown() {
        viewModel = nil
        mockITunesService = nil
        mockStorageManager = nil
        super.tearDown()
    }

    func test_GivenSearchTerm_WhenDidTypeSearch_ThenServiceReceivesTerm() {
        // Given
        let term = "SomeAlbum"

        // When
        viewModel.didTypeSearch(term)

        // Then
        XCTAssertEqual(mockITunesService.loadAlbumsArgsTerms.first, term)
    }

    func test_GivenSearchTerm_WhenSearchButtonClicked_ThenSearchTermIsSaved() {
        // Given
        let term = "SomeAlbum"

        // When
        viewModel.searchButtonClicked(with: term)

        // Then
        XCTAssertEqual(mockStorageManager.searchHistory.first, term)
    }

    func test_GivenSavedAlbums_WhenSearchFromHistory_ThenAlbumsAreDisplayedFromStorage() {
        // Given
        let term = "SomeAlbum"
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

        mockStorageManager.saveAlbums(albums, for: term)

        // When
        viewModel.searchFromHistory(with: term)

        // Then
        XCTAssertEqual(viewModel.albums.value, albums)
        XCTAssertEqual(mockITunesService.loadAlbumsCallCount, 0)
    }

    func test_GivenSavedAlbums_WhenSearchAlbums_ThenAlbumsAreDisplayedFromStorage() {
        // Given
        let term = "SavedAlbums"
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

        mockStorageManager.saveAlbums(albums, for: term)

        // When
        viewModel.searchAlbums(with: term)

        // Then
        XCTAssertEqual(viewModel.albums.value, albums)
        XCTAssertEqual(mockITunesService.loadAlbumsCallCount, 0)
    }

    func test_GivenNewAlbums_WhenSearchAlbums_ThenAlbumsAreFetchedAndDisplayed() {
        // Given
        let term = "Eminem"
        let albums = [
            Album(artistId: 111051,
                  artistName: "Eminem",
                  collectionName: "The Eminem Show",
                  artworkUrl100: "url_to_image",
                  collectionPrice: 10.99
                 )
        ]

        mockITunesService.stubbedAlbumsResult = .success(albums)

        // When
        viewModel.searchAlbums(with: term)

        // Then
        XCTAssertEqual(viewModel.albums.value, albums)
        XCTAssertEqual(mockITunesService.loadAlbumsCallCount, 1)
        XCTAssertEqual(mockITunesService.loadAlbumsArgsTerms.first, term)
        let savedAlbums = mockStorageManager.loadAlbums(for: term)
        XCTAssertEqual(savedAlbums, albums)
    }
}
