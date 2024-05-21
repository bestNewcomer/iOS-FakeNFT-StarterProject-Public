//
//  AppConfiguration.swift
//  FakeNFT
//
//  Created by Леонид Турко on 05.04.2024.
//

import UIKit

final class AppConfiguration {
  let catalogViewController: UIViewController
  let profileViewController: ProfileViewController
  var servicesAssembly: ServicesAssembly!
  private let catalogNavigationController: UINavigationController
  private let cartService: CartControllerProtocol
  let cartViewController: CartViewController
  
  init() {
    let servicesAssembly = ServicesAssembly(networkClient: DefaultNetworkClient(), nftStorage: NftStorageImpl(), orderStorage: OrderStorage(),
        nftByIdStorage: NftByIdStorage())
    let profilePresenter = ProfilePresenter()
    profileViewController = ProfileViewController(servicesAssembly: servicesAssembly)
    profileViewController.presenter = profilePresenter
    profilePresenter.view = profileViewController
    
    let dataProvider = CatalogDataProvider(networkClient: DefaultNetworkClient())
    let router = CatalogRouter()
    
    let catalogPresenter = CatalogPresenter(dataProvider: dataProvider, router: router)
    cartService = CartService()
    
    let catalogViewController = CatalogViewController(presenter: catalogPresenter, cartService: cartService)
    self.catalogViewController = catalogViewController
    catalogPresenter.viewController = catalogViewController
    catalogNavigationController = UINavigationController(rootViewController: catalogViewController)
    router.viewController = catalogViewController
      
    let cartController = CartViewController(servicesAssembly: servicesAssembly)
    self.cartViewController = cartController
    let cartNavigationController = UINavigationController(rootViewController: cartController)
  }
}
