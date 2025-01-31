//
//  AlbumCollectionViewDataSourceProtocol.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

import Foundation
import UIKit

protocol SearchDataSourceProtocol: AnyObject, UICollectionViewDataSource {
    var viewModel: SearchViewModelProtocol? { get set }
    var networkManager: NetworkManagerProtocol? { get set }
}
