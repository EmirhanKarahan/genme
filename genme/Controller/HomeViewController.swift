//
//  HomeViewController.swift
//  genme
//
//  Created by Emirhan Karahan on 12.08.2023.
//

import UIKit
import SnapKit
import SkeletonView

enum MemeError: Error {
    case invalidServerResponse
    case invalidImage
    case invalidURL
}

final class HomeViewController: UIViewController {
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 25.rW(), bottom: 50.rH(), right: 25.rW())
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.isSkeletonable = true
        collectionview.showAnimatedGradientSkeleton()
        collectionview.register(MemeSelectionCollectionViewCell.self, forCellWithReuseIdentifier: MemeSelectionCollectionViewCell.identifier)
        return collectionview
    }()
    
    private var memes: [Meme] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HOME_PAGE_TITLE"
        
        setupViews()
        fetchApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubviews(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension HomeViewController {
    
    private func fetchApi() {
        guard let url = URL(string: Constants.API_URL) else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                debugPrint("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                debugPrint("Error with the response, unexpected status code: \(response)")
                return
            }
            
            if let data = data, let memeDataResponse = try? JSONDecoder().decode(MemeResponseModel.self, from: data) {
                self.memes = memeDataResponse.data?.memes ?? []
                DispatchQueue.main.async {
                    self.collectionView.hideSkeleton()
                    self.collectionView.reloadData()
                }
                
            }
        })
        task.resume()
    }
    
}

extension HomeViewController: UICollectionViewDelegate, SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return MemeSelectionCollectionViewCell.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeSelectionCollectionViewCell.identifier,
                                                      for: indexPath) as! MemeSelectionCollectionViewCell
        cell.textLabel.text = memes[indexPath.row].name
        cell.imageUrl = memes[indexPath.row].url
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MemeEditController()
        vc.imageUrl = memes[indexPath.row].url
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
