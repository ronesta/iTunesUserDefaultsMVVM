//
//  AlbumViewModel.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

import Foundation
import UIKit

final class AlbumViewModel: AlbumViewModelProtocol {
    private let imageLoader: ImageLoaderProtocol

    private var album: Album

    let albumImage: Observable<UIImage?> = Observable(nil)
    let albumName: Observable<String?> = Observable(nil)
    let artistName: Observable<String?> = Observable(nil)
    let collectionPrice: Observable<String?> = Observable(nil)

    init(imageLoader: ImageLoaderProtocol,
         album: Album
    ) {
        self.imageLoader = imageLoader
        self.album = album
        setupBindings()
    }

    private func setupBindings() {
        albumName.value = album.collectionName
        artistName.value = album.artistName
        collectionPrice.value = "\(album.collectionPrice) $"

        let urlString = album.artworkUrl100
        imageLoader.loadImage(from: urlString) { [weak self] loadedImage in
            DispatchQueue.main.async {
                self?.albumImage.value = loadedImage
            }
        }
    }

    func fetchAlbumImage(completion: @escaping (UIImage?) -> Void) {
        imageLoader.loadImage(from: album.artworkUrl100, completion: completion)
    }
}
