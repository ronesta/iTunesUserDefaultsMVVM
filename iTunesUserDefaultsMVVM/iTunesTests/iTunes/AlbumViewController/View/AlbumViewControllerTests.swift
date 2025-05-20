//
//  AlbumViewControllerTests.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 20.04.2025.
//

import XCTest
@testable import iTunesUserDefaultsMVVM

final class AlbumViewControllerTests: XCTestCase {
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

    func test_givenViewModelWithAlbumImage_whenAlbumImageChanges_thenAlbumImageViewUpdates() {
        // Given
        let expectedImage = UIImage(systemName: "checkmark")

        // When
        mockViewModel.albumImage.value = expectedImage

        // Then
        XCTAssertEqual(viewController.albumImageView.image, expectedImage)
    }

    func test_givenViewModelWithAlbumName_whenAlbumNameChanges_thenAlbumNameLabelUpdates() {
        // Given
        let expectedName = "Test Album"

        // When
        mockViewModel.albumName.value = expectedName

        // Then
        XCTAssertEqual(viewController.albumNameLabel.text, expectedName)
    }

    func test_givenViewModelWithArtistName_whenArtistNameChanges_thenArtistNameLabelUpdates() {
        // Given
        let expectedArtist = "Test Artist"

        // When
        mockViewModel.artistName.value = expectedArtist

        // Then
        XCTAssertEqual(viewController.artistNameLabel.text, expectedArtist)
    }

    func test_givenViewModelWithCollectionPrice_whenCollectionPriceChanges_thenCollectionPriceLabelUpdates() {
        // Given
        let expectedPrice = "$9.99"

        // When
        mockViewModel.collectionPrice.value = expectedPrice

        // Then
        XCTAssertEqual(viewController.collectionPriceLabel.text, expectedPrice)
    }
}
