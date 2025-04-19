//
//  MockSearchDataSource.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 19.04.2025.
//

import UIKit
@testable import iTunesUserDefaultsMVVM

final class MockSearchDataSource: NSObject, SearchDataSourceProtocol {
    private let viewModel: SearchViewModelProtocol

    init(viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getAlbumsCount()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AlbumCollectionViewCell.id,
            for: indexPath)
                as? AlbumCollectionViewCell else {
            return UICollectionViewCell()
        }

        let album = viewModel.getAlbum(at: indexPath.row)
        let image = UIImage(systemName: "checkmark.diamond")

        let viewModel = AlbumCellViewModel(album: album, image: image)
        cell.configure(with: viewModel)

        return cell
    }
}
