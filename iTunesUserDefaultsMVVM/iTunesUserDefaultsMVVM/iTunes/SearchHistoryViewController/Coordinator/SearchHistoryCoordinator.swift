//
//  SearchHistoryCoordinator.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 13.03.2025.
//

import Foundation
import UIKit

final class SearchHistoryCoordinator: SearchHistoryCoordinatorProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func didSelectSearchQuery(with term: String) {
        let searchAssembly = SearchAssembly()

        if let searchViewController = searchAssembly.build() as? UINavigationController,
           let rootViewController = searchViewController.viewControllers.first as? SearchViewController {
            rootViewController.performSearch(with: term)
            navigationController.pushViewController(rootViewController, animated: true)
        }
    }
}
