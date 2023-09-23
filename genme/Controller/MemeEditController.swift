//
//  MemeEditController.swift
//  genme
//
//  Created by Emirhan Karahan on 23.09.2023.
//

import UIKit
import SkeletonView

final class MemeEditController: UIViewController {
    
    private lazy var imageView: MemeImageView = {
        let imageView = MemeImageView()
        imageView.image = UIImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isSkeletonable = true
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.addShadow(offset: CGSize(width: 0, height: 2), opacity: 0.9)
        return imageView
    }()

    var imageUrl: String? {
        didSet {
            Task {
                try await imageView.loadImage(urlString: imageUrl)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "EDIT_PAGE_TITLE"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .systemBackground
        view.addSubviews(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.lessThanOrEqualToSuperview().offset(-20)
            make.height.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.height).offset(-80)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
        }

    }

}
