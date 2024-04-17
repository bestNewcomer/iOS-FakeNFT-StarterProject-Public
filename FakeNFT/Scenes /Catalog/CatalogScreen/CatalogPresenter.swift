//
//  CatalogPresenter.swift
//  FakeNFT
//
//  Created by Леонид Турко on 05.04.2024.
//

import Foundation

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
  
  private var dataSource: [NFTCollection] {
    dataProvider.getCollectionNFT()
  }
  
  init(dataProvider: CatalogDataProviderProtocol) {
    self.dataProvider = dataProvider
  }
  
  func fetchCollections(completion: @escaping ([NFTCollection]) -> Void) {
    dataProvider.fetchNFTCollection { [weak self] updatedData in
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
