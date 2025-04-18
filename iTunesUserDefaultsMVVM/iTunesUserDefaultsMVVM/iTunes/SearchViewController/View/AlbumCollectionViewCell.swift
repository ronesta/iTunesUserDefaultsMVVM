//
//  AlbumCollectionViewCell.swift
//  iTunesUserDefaultsMVVM
//
//  Created by Ибрагим Габибли on 25.01.2025.
//

import UIKit
import SnapKit

final class AlbumCollectionViewCell: UICollectionViewCell {
    static let id = "AlbumCollectionViewCell"

    private let albumImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.accessibilityIdentifier = "albumImageView"
        return image
    }()

    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.accessibilityIdentifier = "albumNameLabel"
        return label
    }()

    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemGray
        label.accessibilityIdentifier = "artistNameLabel"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        customizeCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        albumImageView.image = nil
        albumNameLabel.text = nil
        artistNameLabel.text = nil
    }

    private func setupViews() {
        contentView.addSubview(albumImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)

        albumImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(100)
        }

        albumNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(albumImageView.snp.top)
        }

        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(albumNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(albumNameLabel)
            make.trailing.equalTo(albumNameLabel)
        }
    }

    private func customizeCell() {
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }

    func configure(with viewModel: AlbumCellViewModel) {
        albumImageView.image = viewModel.albumImage
        albumNameLabel.text = viewModel.collectionName
        artistNameLabel.text = viewModel.artistName
    }
}
