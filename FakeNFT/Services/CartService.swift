//
//  CartService.swift
//  FakeNFT
//
//  Created by Леонид Турко on 11.04.2024.
//

final class CartService: CartControllerProtocol {
  var cart: [Nft] = []
  
  func addToCart(_ nft: Nft, completion: (() -> Void)?) { }
  
  func removeFromCart(_ id: String, completion: (() -> Void)?) { }
  
  func removeAll(completion: (() -> Void)?) { }
  
  weak var delegate: CartControllerDelegate?
  
  private var _cart: [Nft] = []
}
