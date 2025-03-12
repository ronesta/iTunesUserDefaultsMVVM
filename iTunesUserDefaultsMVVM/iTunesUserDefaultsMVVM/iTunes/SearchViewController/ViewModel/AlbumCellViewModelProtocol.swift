//
//  AlbumCellViewModelProtocol.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

import UIKit

protocol AlbumCellViewModelProtocol {
    var collectionName: String { get }
    var artistName: String { get }
    var albumImage: UIImage? { get }

    init(album: Album, image: UIImage?)
}
