//
//  SearchViewControllerTests.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 19.04.2025.
//

import XCTest
import ViewControllerPresentationSpy
@testable import iTunesUserDefaultsMVVM

final class SearchViewControllerTests: XCTestCase {
    private var mockViewModel: MockSearchViewModel!
    private var mocDataSource: MockSearchDataSource!
    private var mockStorageManager: MockStorageManager!
    private var viewController: SearchViewController!

    override func setUp() {
        super.setUp()
        mockViewModel = MockSearchViewModel()
        mocDataSource = MockSearchDataSource(viewModel: mockViewModel)
        mockStorageManager = MockStorageManager()
        viewController = SearchViewController(
            viewModel: mockViewModel,
            storageManager: mockStorageManager,
            collectionViewDataSource: mocDataSource
        )
    }

    func testSearchBarSearchButtonClickedCallsViewModel() {
        let term = "Test Search"

        viewController.searchBar.text = term
        viewController.searchBarSearchButtonClicked(viewController.searchBar)

        XCTAssertEqual(mockViewModel.searchButtonClickedTerm, term)
    }

    func testSearchBarTextDidChangeCallsViewModel() {
        let term = "New Search"

        viewController.searchBar(viewController.searchBar, textDidChange: term)
        XCTAssertEqual(mockViewModel.didTypeSearchText, term)
    }

    func testTableViewReloadsWhenViewModelAlbumsChanges() {
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

        mockViewModel.albums.value = albums

        XCTAssertEqual(mockViewModel.getAlbumsCount(), albums.count)
        XCTAssertEqual(mockViewModel.getAlbum(at: 0).collectionName, "The Eminem Show")
        XCTAssertEqual(mockViewModel.getAlbum(at: 1).collectionName, "Levitating")
    }

    func testPerformSearchHidesSearchBarAndCallsViewModel() {
        let term = "SomeTerm"

        viewController.searchBar.isHidden = false
        viewController.performSearch(with: term)

        XCTAssertTrue(viewController.searchBar.isHidden)
        XCTAssertEqual(mockViewModel.searchFromHistoryTerm, term)
    }
}
