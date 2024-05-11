//
//  OrderModel.swift
//  FakeNFT
//
//  Created by Леонид Турко on 12.04.2024.
//

import Foundation

struct OrderModel: Codable {
  let nfts: [String]?
  let id: String
  
  func update(newNfts: [String]? = nil) -> OrderModel {
    .init(
      nfts: newNfts ?? nfts,
      id: id
    )
  }
}
