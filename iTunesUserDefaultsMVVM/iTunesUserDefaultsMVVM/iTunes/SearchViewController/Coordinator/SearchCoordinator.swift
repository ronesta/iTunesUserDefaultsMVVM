//
//  SearchCoordinator.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 13.03.2025.
//

import Foundation
import UIKit

final class SearchCoordinator: SearchCoordinatorProtocol {
    private let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func didSelect(album: Album) {
        let albumAssembly = AlbumAssembly()

        let albumViewController = albumAssembly.build(with: album)
        viewController.navigationController?.pushViewController(albumViewController, animated: true)
    }
}
