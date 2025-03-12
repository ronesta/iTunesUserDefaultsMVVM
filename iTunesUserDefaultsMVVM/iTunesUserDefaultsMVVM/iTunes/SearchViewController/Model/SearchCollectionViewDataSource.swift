//
//  AlbumCollectionViewDataSource.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

import Foundation
import UIKit

final class SearchCollectionViewDataSource: NSObject, SearchDataSourceProtocol {
    private let viewModel: SearchViewModelProtocol
    private let imageLoader: ImageLoaderProtocol

    init(viewModel: SearchViewModelProtocol,
         imageLoader: ImageLoaderProtocol
    ) {
        self.viewModel = viewModel
        self.imageLoader = imageLoader
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getAlbumsCount()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AlbumCollectionViewCell.id,
            for: indexPath)
                as? AlbumCollectionViewCell else {
            return UICollectionViewCell()
        }

        let album = viewModel.getAlbum(at: indexPath.item)
        let urlString = album.artworkUrl100

        imageLoader.loadImage(from: urlString) { loadedImage in
            DispatchQueue.main.async {
                guard let cell = collectionView.cellForItem(at: indexPath) as? AlbumCollectionViewCell else {
                    return
                }

                let viewModel = AlbumCellViewModel(album: album, image: loadedImage)
                cell.configure(with: viewModel)
            }
        }
        return cell
    }
}
