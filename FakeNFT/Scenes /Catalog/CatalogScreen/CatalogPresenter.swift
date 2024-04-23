//
//  CatalogPresenter.swift
//  FakeNFT
//
//  Created by Леонид Турко on 05.04.2024.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol CatalogPresenterProtocol: AnyObject {
  var viewController: CatalogViewControllerProtocol? { get set }
  func fetchCollections(completion: @escaping ([NFTCollection]) -> Void)
  func sortNFTS(by: NFTCollectionsSortOptions)
  func getDataSource() -> [NFTCollection]
}

// MARK: - Final Class

final class CatalogPresenter: CatalogPresenterProtocol {
  
  weak var viewController: CatalogViewControllerProtocol?
  private var dataProvider: CatalogDataProviderProtocol
  private let router: CatalogRouterProtocol
  private var dataSource: [NFTCollection] {
    dataProvider.getCollectionNFT()
  }
  
  init(dataProvider: CatalogDataProviderProtocol, router: CatalogRouterProtocol) {
    self.dataProvider = dataProvider
    self.router = router
  }
  
  func fetchCollections(completion: @escaping ([NFTCollection]) -> Void) {
    dataProvider.fetchNFTCollection { [weak self] _, error in
      if let error {
        let alertViewController = UIAlertController(title: "Не удалось загрузить NFT", message: error.localizedDescription, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Попробовать снова", style: .default, handler: { [weak self] _ in
          self?.fetchCollections(completion: completion)
        }))
        alertViewController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self?.router.presentViewController(alertViewController)
        return
      }
      self?.viewController?.reloadTableView()
    }
  }
  
  func getDataSource() -> [NFTCollection] {
    return self.dataSource
  }
  
  func sortNFTS(by: NFTCollectionsSortOptions) {
    dataProvider.sortNFTCollections(by: by)
  }
}
