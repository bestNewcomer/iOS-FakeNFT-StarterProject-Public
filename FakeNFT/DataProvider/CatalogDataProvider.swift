//
//  CatalogDataProvider.swift
//  FakeNFT
//
//  Created by Леонид Турко on 05.04.2024.
//

import Foundation
import ProgressHUD

// MARK: - Protocol

protocol CatalogDataProviderProtocol: AnyObject {
  func fetchNFTCollection(completion: @escaping ([NFTCollection], Error?) -> Void)
  func sortNFTCollections(by: NFTCollectionsSortOptions)
  func getCollectionNFT() -> [NFTCollection]
}

// MARK: - Final Class

final class CatalogDataProvider: CatalogDataProviderProtocol {
  private var collectionNFT: [NFTCollection] = []
  let networkClient: DefaultNetworkClient
  
  init(networkClient: DefaultNetworkClient) {
    self.networkClient = networkClient
  }
  
  func getCollectionNFT() -> [NFTCollection] {
    return self.collectionNFT
  }
  
  func fetchNFTCollection(completion: @escaping ([NFTCollection], Error?) -> Void) {
    ProgressHUD.show()
    networkClient.send(request: NFTTableViewRequest(), type: [NFTCollection].self) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let nft):
        self.collectionNFT = nft
        completion(nft, nil)
      case .failure(let error):
        completion([], error)
      }
      ProgressHUD.dismiss()
    }
  }
  
  func sortNFTCollections(by: NFTCollectionsSortOptions) {
    switch by {
    case .name:
      collectionNFT.sort { $0.name < $1.name }
    case .nftCount:
      collectionNFT.sort { $0.nfts.count < $1.nfts.count }
    }
  }
}
