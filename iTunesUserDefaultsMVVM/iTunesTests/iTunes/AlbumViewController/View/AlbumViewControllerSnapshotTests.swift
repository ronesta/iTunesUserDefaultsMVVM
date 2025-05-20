//
//  AlbumViewControllerSnapshotTests.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 20.04.2025.
//

import XCTest
import SnapshotTesting
@testable import iTunesUserDefaultsMVVM

final class AlbumViewControllerSnapshotTests: XCTestCase {
    private var mockViewModel: MockAlbumViewModel!
    private var viewController: AlbumViewController!

    override func setUp() {
        super.setUp()
        mockViewModel = MockAlbumViewModel()
        viewController = AlbumViewController(viewModel: mockViewModel)
        _ = viewController.view
    }

    override func tearDown() {
        viewController = nil
        mockViewModel = nil
        super.tearDown()
    }

    func test_GivenAlbumData_WhenViewIsLoaded_ThenSnapshotMatchesAppearance() {
        // Given
        let image = UIImage(systemName: "checkmark.diamond")
        let album = Album(artistId: 111051,
                          artistName: "Eminem",
                          collectionName: "The Eminem Show",
                          artworkUrl100: "url_to_image",
                          collectionPrice: 10.99
                         )

        mockViewModel.albumImage.value = image
        mockViewModel.albumName.value = album.collectionName
        mockViewModel.artistName.value = album.artistName
        mockViewModel.collectionPrice.value = "\(album.collectionPrice) $"

        // When view is already loaded in setUp

        // Then
        assertSnapshot(of: viewController, as: .image)
    }
}
