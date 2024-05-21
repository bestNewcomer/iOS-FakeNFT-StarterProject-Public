//
//  CatalogСollectionPresenter.swift
//  FakeNFT
//
//  Created by Леонид Турко on 09.04.2024.
//

import Foundation

// MARK: - Protocol

protocol CatalogСollectionPresenterProtocol: AnyObject {
  var viewController: CatalogСollectionViewControllerProtocol? { get set }
  var userURL: String? { get }
  var nftArray: [Nft] { get }
  func loadNFTs()
  func getUserProfile() -> ProfileModel?
  func getUserOrder() -> OrderModel?
  func loadUserProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void)
  func loadUserOrder(completion: @escaping (Result<OrderModel, Error>) -> Void)
  func isAlreadyLiked(nftId: String) -> Bool
  func isAlreadyInCart(nftId: String) -> Bool
  func presentCollectionViewData()
  func toggleLikeStatus(model: Nft)
  func toggleCartStatus(model: Nft)
}

// MARK: - Final Class

final class CatalogСollectionPresenter: CatalogСollectionPresenterProtocol {
  
  func getUserProfile() -> ProfileModel? {
    return self.userProfile
  }
  
  func getUserOrder() -> OrderModel? {
    return self.userOrder
  }
  
  weak var viewController: CatalogСollectionViewControllerProtocol?
  private var dataProvider: CollectionDataProvider
  private var userProfile: ProfileModel?
  private var userOrder: OrderModel?
  
  let cartController: CartControllerProtocol
  let nftModel: NFTCollection
  var userURL: String?
  var nftArray: [Nft] = []
  var profileModel: [ProfileModel] = []
  
  init(nftModel: NFTCollection, dataProvider: CollectionDataProvider, cartController: CartControllerProtocol) {
    self.nftModel = nftModel
    self.dataProvider = dataProvider
    self.cartController = cartController
  }
  
  func presentCollectionViewData() {
    let viewData = CatalogCollectionViewData(
      coverImageURL: nftModel.cover,
      title: nftModel.name,
      description: nftModel.description,
      authorName: nftModel.author)
    viewController?.renderViewData(viewData: viewData)
  }
  
  func setUserProfile(_ profile: ProfileModel) {
    self.userProfile = profile
  }
  
  func setUserOrder(_ order: OrderModel) {
    self.userOrder = order
  }
  
  func loadUserProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void) {
    dataProvider.getUserProfile { [weak self] result in
      switch result {
      case .success(let profileModel):
        self?.setUserProfile(profileModel)
        completion(.success(profileModel))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func loadUserOrder(completion: @escaping (Result<OrderModel, Error>) -> Void) {
    dataProvider.getUserOrder() { [weak self] result in
      switch result {
      case .success(let order):
        self?.setUserOrder(order)
        completion(.success(order))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func loadNFTs() {
    var nftArray: [Nft] = []
    let group = DispatchGroup()
    
    for nft in nftModel.nfts {
      group.enter()
      dataProvider.loadNFTsBy(id: nft) { result in
        switch result {
        case .success(let data):
          nftArray.append(data)
        case .failure(_): break
        }
        group.leave()
      }
    }
    group.wait()
    group.notify(queue: .main) {
      self.nftArray = nftArray
      self.viewController?.reloadCollectionView()
    }
    
    self.loadUserProfile() { updateResult in
      switch updateResult {
      case .success(_):
        self.viewController?.reloadVisibleCells()
      case .failure:
        break
      }
    }
    
    self.loadUserOrder() { updateResult in
      switch updateResult {
      case .success(_):
        self.viewController?.reloadVisibleCells()
      case .failure:
        break
      }
    }
  }
  
  func isAlreadyLiked(nftId: String) -> Bool {
    return self.userProfile?.likes?.contains { $0 == nftId } == true
  }
  
  func isAlreadyInCart(nftId: String) -> Bool {
    return self.userOrder?.nfts?.contains {$0 == nftId } == true
  }
  
  func toggleLikeStatus(model: Nft) {
    guard let profileModel = self.userProfile else {
      return
    }
    
    let updatedLikes = self.isAlreadyLiked(nftId: model.id)
    ? profileModel.likes?.filter { $0 != model.id }
    : (profileModel.likes ?? []) + [model.id]
    
    let updatedProfileModel = profileModel.update(newLikes: updatedLikes)
    
    dataProvider.updateUserProfile(with: updatedProfileModel) { updateResult in
      switch updateResult {
      case .success(let result):
        self.setUserProfile(result)
        self.viewController?.reloadVisibleCells()
      case .failure:
        break
      }
    }
  }
  
  func toggleCartStatus(model: Nft) {
    guard let orderModel = self.userOrder else {
      return
    }
    
    let updatedNfts = isAlreadyInCart(nftId: model.id)
    ? orderModel.nfts?.filter { $0 != model.id }
    : (orderModel.nfts ?? []) + [model.id]
    
    let updatedOrderModel = orderModel.update(newNfts: updatedNfts)
    
    dataProvider.updateUserOrder(with: updatedOrderModel) { updateResult in
      switch updateResult {
      case .success(let result):
        self.setUserOrder(result)
        self.viewController?.reloadVisibleCells()
      case .failure:
        break
      }
    }
  }
}
