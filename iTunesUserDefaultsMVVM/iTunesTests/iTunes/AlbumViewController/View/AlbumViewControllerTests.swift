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

    func testAlbumImageViewUpdatesWithViewModel() {
        let expectedImage = UIImage(systemName: "checkmark")
        mockViewModel.albumImage.value = expectedImage

        XCTAssertEqual(viewController.albumImageView.image, expectedImage)
    }

    func testAlbumNameLabelUpdatesWithViewModel() {
        let expectedName = "Test Album"
        mockViewModel.albumName.value = expectedName

        XCTAssertEqual(viewController.albumNameLabel.text, expectedName)
    }

    func testArtistNameLabelUpdatesWithViewModel() {
        let expectedArtist = "Test Artist"
        mockViewModel.artistName.value = expectedArtist

        XCTAssertEqual(viewController.artistNameLabel.text, expectedArtist)
    }

    func testCollectionPriceLabelUpdatesWithViewModel() {
        let expectedPrice = "$9.99"
        mockViewModel.collectionPrice.value = expectedPrice

        XCTAssertEqual(viewController.collectionPriceLabel.text, expectedPrice)
    }
}
