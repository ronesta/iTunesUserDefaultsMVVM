//
//  ViewController.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 25.01.2025.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search Albums"
        searchBar.sizeToFit()
        return searchBar
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 15, height: 130)
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.register(
            AlbumCollectionViewCell.self,
            forCellWithReuseIdentifier: AlbumCollectionViewCell.id
        )

        return collectionView
    }()

    let viewModel: SearchViewModelProtocol
    private let storageManager: StorageManagerProtocol
    private let collectionViewDataSource: SearchDataSourceProtocol

    init(viewModel: SearchViewModelProtocol,
         storageManager: StorageManagerProtocol,
         collectionViewDataSource: SearchDataSourceProtocol
    ) {
        self.viewModel = viewModel
        self.storageManager = storageManager
        self.collectionViewDataSource = collectionViewDataSource
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }

    private func setupViews() {
        view.backgroundColor = .systemGray6
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        navigationItem.titleView = searchBar

        searchBar.delegate = self
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = self

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }

    private func setupBindings() {
        viewModel.albums.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let album = viewModel.getAlbum(at: indexPath.item)
        let albumAssembly = AlbumAssembly()

        let albumViewController = albumAssembly.build(with: album)

        navigationController?.pushViewController(albumViewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
            return
        }
        storageManager.saveSearchTerm(searchTerm)
        viewModel.searchAlbums(with: searchTerm)
    }
}
