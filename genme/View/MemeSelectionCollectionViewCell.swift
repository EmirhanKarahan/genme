//
//  MemeSelectionCollectionViewCell.swift
//  genme
//
//  Created by Emirhan Karahan on 12.08.2023.
//

import UIKit
import SnapKit
import SkeletonView

final class MemeSelectionCollectionViewCell: UICollectionViewCell {

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal
    
    static let identifier = "MemeSelectionCollectionViewCell"

    // MARK: Private

    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private lazy var imageView: MemeImageView = {
        let imageView = MemeImageView()
        imageView.image = UIImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isSkeletonable = true
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var imageUrl: String? {
        didSet {
            Task {
                isUserInteractionEnabled = false
                try await imageView.loadImage(urlString: imageUrl)
                isUserInteractionEnabled = true
            }
        }
    }
    
    private func setupViews() {
        isSkeletonable = true
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .secondarySystemFill
        contentView.addSubviews(textLabel, imageView)
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(170.rW())
            make.height.equalTo(240)
        }

        imageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            make.top.equalTo(contentView.snp.top).offset(5)
            make.height.equalTo(180)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            make.top.equalTo(imageView.snp.bottom).offset(2)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
        
    }
    
}
