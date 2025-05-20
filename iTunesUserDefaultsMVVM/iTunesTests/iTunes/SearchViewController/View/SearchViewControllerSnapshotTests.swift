//
//  SearchViewControllerSnapshotTests.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 19.04.2025.
//

import XCTest
import SnapshotTesting
@testable import iTunesUserDefaultsMVVM

final class SearchViewControllerSnapshotTests: XCTestCase {
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

    override func tearDown() {
        viewController = nil
        mockViewModel = nil
        mocDataSource = nil
        mockStorageManager = nil
        super.tearDown()
    }

    func test_GivenNoAlbums_WhenViewLoaded_ThenViewControllerAppearanceMatchesSnapshot() {
        // Given
        let navigationController = UINavigationController(rootViewController: viewController)

        // When
        viewController.loadViewIfNeeded()

        // Then
        assertSnapshot(of: navigationController, as: .image)
    }

    func test_GivenViewController_WhenAlbumsLoaded_ThenItMatchesSnapshot() {
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
    
        let navigationController = UINavigationController(rootViewController: viewController)

        // When
        mockViewModel.albums.value = albums

        // Then
        assertSnapshot(of: navigationController, as: .image)
    }
}
