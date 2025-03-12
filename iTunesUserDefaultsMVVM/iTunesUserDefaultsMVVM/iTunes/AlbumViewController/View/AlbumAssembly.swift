//
//  AlbumAssembly.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 01.02.2025.
//

import Foundation
import UIKit

final class AlbumAssembly {
    func build(with album: Album) -> UIViewController {
        let storageManager = StorageManager()
        let imageLoader = ImageLoader(storageManager: storageManager)

        let albumViewModel = AlbumViewModel(imageLoader: imageLoader,
                                            album: album
        )

        let albumViewController = AlbumViewController(viewModel: albumViewModel)

        return albumViewController
    }
}
