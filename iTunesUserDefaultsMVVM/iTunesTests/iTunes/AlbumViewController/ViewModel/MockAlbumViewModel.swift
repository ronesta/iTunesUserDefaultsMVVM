//
//  MockAlbumViewModel.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 20.04.2025.
//

import UIKit
@testable import iTunesUserDefaultsMVVM

final class MockAlbumViewModel: AlbumViewModelProtocol {
    var albumImage: Observable<UIImage?> = Observable(nil)
    var albumName: Observable<String?> = Observable(nil)
    var artistName: Observable<String?> = Observable(nil)
    var collectionPrice: Observable<String?> = Observable(nil)
}
