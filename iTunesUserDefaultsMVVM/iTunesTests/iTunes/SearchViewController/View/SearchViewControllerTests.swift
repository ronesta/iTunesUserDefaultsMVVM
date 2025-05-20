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
    private var viewController: SearchViewController!
    private var mockViewModel: MockSearchViewModel!
    private var mocDataSource: MockSearchDataSource!
    private var mockStorageManager: MockStorageManager!

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

    override func tearDown() {
        viewController = nil
        mockViewModel = nil
        mocDataSource = nil
        mockStorageManager = nil
        super.tearDown()
    }

    func test_GivenSearchBarWithText_WhenSearchButtonClicked_ThenViewModelIsNotified() {
        // Given
        let term = "Test Search"
        viewController.searchBar.text = term

        // When
        viewController.searchBarSearchButtonClicked(viewController.searchBar)

        // Then
        XCTAssertEqual(mockViewModel.searchButtonClickedCallCount, 1)
        XCTAssertEqual(mockViewModel.searchButtonClickedArgsTerms, [term])
    }

    func test_GivenUserTypesInSearchBar_WhenTextDidChange_ThenViewModelIsNotified() {
        // Given
        let term = "New Search"

        // When
        viewController.searchBar(viewController.searchBar, textDidChange: term)

        // Then
        XCTAssertEqual(mockViewModel.didTypeSearchCallCount, 1)
        XCTAssertEqual(mockViewModel.didTypeSearchArgsTexts, [term])
    }

    func test_GivenAlbumsInViewModel_WhenAlbumsChange_ThenTableViewReloads() {
        // Given
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

        // When
        mockViewModel.albums.value = albums

        // Then
        XCTAssertEqual(mockViewModel.getAlbumsCount(), albums.count)
        XCTAssertEqual(mockViewModel.getAlbum(at: 0).collectionName, "The Eminem Show")
        XCTAssertEqual(mockViewModel.getAlbum(at: 1).collectionName, "Levitating")
    }

    func test_GivenSearchQueryInHistory_WhenPerformSearch_ThenSearchBarHidesAndViewModelIsNotified() {
        // Given
        let term = "SomeTerm"
        viewController.searchBar.isHidden = false

        // When
        viewController.performSearch(with: term)

        // Then
        XCTAssertTrue(viewController.searchBar.isHidden)
        XCTAssertEqual(mockViewModel.searchFromHistoryCallCount, 1)
        XCTAssertEqual(mockViewModel.searchFromHistoryArgsTerms, [term])
    }
}
