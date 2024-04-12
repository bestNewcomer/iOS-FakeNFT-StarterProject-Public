//
//  AppConfiguration.swift
//  FakeNFT
//
//  Created by Леонид Турко on 05.04.2024.
//

import UIKit

final class AppConfiguration {
  let catalogViewController: UIViewController
  private let catalogNavigationController: UINavigationController
  private let cartService: CartControllerProtocol
  
  init() {
    let dataProvider = CatalogDataProvider(networkClient: DefaultNetworkClient())
    let catalogPresenter = CatalogPresenter(dataProvider: dataProvider)
    cartService = CartService()
    
    catalogViewController = CatalogViewController(presenter: catalogPresenter, cartService: cartService)
    catalogNavigationController = UINavigationController(rootViewController: catalogViewController)
  }
}
