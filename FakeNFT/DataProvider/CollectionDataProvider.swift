//
//  CollectionDataProvider.swift
//  FakeNFT
//
//  Created by Леонид Турко on 10.04.2024.
//

import Foundation
import ProgressHUD

// MARK: - Protocol

protocol  CollectionDataProviderProtocol: AnyObject {
  func fetchCollectionDataById(id: String, completion: @escaping (NFTCollection) -> Void)
  func getCollectionData() -> NFTCollection
  func loadNFTsBy(id: String, completion: @escaping (Result<Nft, Error>) -> Void)
  func updateUserProfile(with profile: ProfileModel, completion: @escaping (Result<ProfileModel, Error>) -> Void)
  func getUserProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void)
}

// MARK: - final class

final class CollectionDataProvider: CollectionDataProviderProtocol {
  
  private var collectionData: NFTCollection? //TODO: default value
  private let networkClient: DefaultNetworkClient
  private var profile: ProfileModel?
  
  init(networkClient: DefaultNetworkClient) {
    self.networkClient = networkClient
  }
  
  func getCollectionData() -> NFTCollection {
    return self.collectionData! //TODO: remove unwrap after giving default value above
  }
  
  func fetchCollectionDataById(id: String, completion: @escaping (NFTCollection) -> Void) {
    ProgressHUD.show()
    networkClient.send(request: CollectionDataRequest(id: id), type: NFTCollection.self) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        self.collectionData = data
        completion(data)
      case .failure(_):
        break
      }
      ProgressHUD.dismiss()
    }
  }
  
  func loadNFTsBy(id: String, completion: @escaping (Result<Nft, Error>) -> Void) {
    ProgressHUD.show()
    networkClient.send(request: NFTGetRequest(id: id), type: Nft.self)  { result in
      completion(result)
    }
    ProgressHUD.dismiss()
  }
  
  func updateUserProfile(with profile: ProfileModel, completion: @escaping (Result<ProfileModel, Error>) -> Void) {
    let updateRequest = ProfileUpdateRequest(profileModel: profile)
    networkClient.send(request: updateRequest, type: ProfileModel.self) { result in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func getUserProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void) {
    networkClient.send(request: ProfileGetRequest(), type: ProfileModel.self) { result in
      switch result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
