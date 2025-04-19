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

    func testDidTypeSearchQueryCallsService() {
        let term = "SomeAlbum"
        viewModel.didTypeSearch(term)

        XCTAssertEqual(mockITunesService.albumName, term)
    }

    func testSearchButtonClickedSavesSearchTerm() {
        let term = "SomeAlbum"
        viewModel.searchButtonClicked(with: term)

        XCTAssertTrue(mockStorageManager.searchHistory.contains(term))
        XCTAssertEqual(mockITunesService.albumName, term)
    }

    func testSearchFromHistoryLoadsAlbums() {
        let term = "SomeAlbum"
        viewModel.searchFromHistory(with: term)

        XCTAssertEqual(mockITunesService.albumName, term)
    }

    func testSearchAlbumsWithSavedAlbums() {
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
        viewModel.searchAlbums(with: term)

        XCTAssertEqual(viewModel.albums.value, albums)
        XCTAssertNil(mockITunesService.albumName)
    }

    func testSearchAlbumsWithNewAlbums() {
        let term = "Eminem"

        let albums = [
            Album(artistId: 111051,
                  artistName: "Eminem",
                  collectionName: "The Eminem Show",
                  artworkUrl100: "url_to_image",
                  collectionPrice: 10.99
                 )
        ]

        mockITunesService.result = .success(albums)
        viewModel.searchAlbums(with: term)

        XCTAssertEqual(viewModel.albums.value, albums)

        let savedAlbums = mockStorageManager.loadAlbums(for: term)
        XCTAssertEqual(savedAlbums, albums)
    }
}
