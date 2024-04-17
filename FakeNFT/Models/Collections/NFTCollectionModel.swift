//
//  NFTCollectionModel.swift
//  FakeNFT
//
//  Created by Леонид Турко on 11.04.2024.
//

import Foundation

struct NFTModel: Decodable {
  let createdAt: String
  let name: String
  let images: [String]
  let rating: Int
  let description: String
  let price: Float
  let author: String
  let id: String
}
