//
//  NetworkManagerProtocol.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//

import Foundation
import UIKit

protocol ITunesServiceProtocol: AnyObject {
    func loadAlbums(albumName: String, completion: @escaping (Result<[Album], Error>) -> Void)
}
