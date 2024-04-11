//
//  FavoritesNFTViewController.swift
//  FakeNFT
//
//  Created by Ринат Шарафутдинов on 11.04.2024.
//

import Foundation
import UIKit

final class FavoritesNFTViewController: UIViewController {
    //MARK:  - Private Properties
    private lazy var returnButton: UIBarButtonItem = {
        let button = UIBarButtonItem( image: UIImage(systemName: "chevron.left"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(returnButtonTap))
        button.tintColor = UIColor(named: "ypBlack")
        return button
    }()
    
    private lazy var favoritesNFTCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor(named: "ypWhite")
        collection.register(FavoritesNFTCell.self, forCellWithReuseIdentifier: FavoritesNFTCell.cellID)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
      }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizingNavigation()
        customizingScreenElements()
        customizingTheLayoutOfScreenElements()
    }
    
    //MARK: - Action
    @objc func returnButtonTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Private Methods
    private func customizingNavigation() {
        navigationController?.navigationBar.backgroundColor = UIColor(named: "ypWhite")
        navigationItem.title = "Избранные NFT"
        navigationItem.leftBarButtonItem = returnButton
    }
    
    private func customizingScreenElements() {
        view.addSubview(favoritesNFTCollectionView)
    }
    
    private func customizingTheLayoutOfScreenElements() {
        NSLayoutConstraint.activate([
            favoritesNFTCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            favoritesNFTCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesNFTCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritesNFTCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesNFTViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesNFTCell.cellID, for: indexPath) as? FavoritesNFTCell else { fatalError("Failed to cast UICollectionViewCell to FavoritesNFTCell")
        }
        switch indexPath.row {
        case 0:
            cell.changingNFT(image: "liloImage", name: "Lilo", rating: 1, price: "1,78 ЕТН")
        case 1:
            cell.changingNFT(image: "liloImage", name: "Lilo", rating: 1, price: "1,78 ЕТН")
        case 2:
            cell.changingNFT(image: "liloImage", name: "Lilo", rating: 1, price: "1,78 ЕТН")
        case 3:
            cell.changingNFT(image: "liloImage", name: "Lilo", rating: 1, price: "1,78 ЕТН")
        case 4:
            cell.changingNFT(image: "liloImage", name: "Lilo", rating: 1, price: "1,78 ЕТН")
        case 5:
            cell.changingNFT(image: "liloImage", name: "Lilo", rating: 1, price: "1,78 ЕТН")
        default:
            break
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritesNFTViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesNFTViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20,
                            left: 16,
                            bottom: 20,
                            right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 168, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        7
    }
}
