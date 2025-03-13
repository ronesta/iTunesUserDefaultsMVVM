//
//  ViewController.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 25.01.2025.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    private let searchBar: UISearchBar = {
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

    private let viewModel: SearchViewModelProtocol
    private let storageManager: StorageManagerProtocol
    private let collectionViewDataSource: SearchDataSourceProtocol

    var onSelect: ((IndexPath) -> Void)?

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
        onSelect?(indexPath)
    }
}

// MARK: - SearchViewInputProtocol
extension SearchViewController: SearchViewInputProtocol {
    func performSearch(with term: String) {
        searchBar.isHidden = true
        viewModel.searchFromHistory(with: term)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.searchButtonClicked(with: searchBar.text)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didTypeSearch(searchText)
    }
}
