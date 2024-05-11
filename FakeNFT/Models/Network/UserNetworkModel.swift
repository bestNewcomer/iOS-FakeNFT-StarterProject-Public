//
//  UserNetworkModel.swift
//  FakeNFT
//
//  Created by Леонид Турко on 11.04.2024.
//

import Foundation

struct UserNetworkModel: Decodable {
  let name: String
  let avatar: String
  let description: String
  let website: String
  let nfts: [String]
  let rating: String
  let id: String
}
