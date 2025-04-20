//
//  AlbumViewModelProtocol.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 31.01.2025.
//
import UIKit

protocol AlbumViewModelProtocol {
    var albumImage: Observable<UIImage?> { get }
    var albumName: Observable<String?> { get }
    var artistName: Observable<String?> { get }
    var collectionPrice: Observable<String?> { get }
}
