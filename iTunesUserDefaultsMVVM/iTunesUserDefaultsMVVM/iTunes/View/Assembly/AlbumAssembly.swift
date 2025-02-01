//
//  AlbumAssembly.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 01.02.2025.
//

import Foundation
import UIKit

struct AlbumAssembly {
    func build(with album: Album) -> UIViewController {
        let storageManager = StorageManager()
        let networkManager = NetworkManager(storageManager: storageManager)
        
        let albumViewModel = AlbumViewModel(networkManager: networkManager,
                                            album: album
        )

        let albumViewController = AlbumViewController(viewModel: albumViewModel)

        return albumViewController
    }
}
