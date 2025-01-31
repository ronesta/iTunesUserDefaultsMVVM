//
//  AlbumCellViewModel.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

import Foundation
import UIKit

struct AlbumCellViewModel {
    let collectionName: String
    let artistName: String
    let albumImage: UIImage?

    init(album: Album, image: UIImage?) {
        self.collectionName = album.collectionName
        self.artistName = album.artistName
        self.albumImage = image
    }
}
