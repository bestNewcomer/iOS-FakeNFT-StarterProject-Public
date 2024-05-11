//
//  CartControllerProtocol.swift
//  FakeNFT
//
//  Created by Леонид Турко on 10.04.2024.
//

import Foundation

protocol CartControllerProtocol {
  var delegate: CartControllerDelegate? { get set }
  var cart: [Nft] { get }
  
  func addToCart(_ nft: Nft, completion: (() -> Void)?)
  func removeFromCart(_ id: String, completion: (() -> Void)?)
  func removeAll(completion: (() -> Void)?)
}

protocol CartControllerDelegate: AnyObject {
  func cartCountDidChanged(_ newCount: Int)
}
