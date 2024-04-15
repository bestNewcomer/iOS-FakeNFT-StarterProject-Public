//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by Леонид Турко on 10.04.2024.
//

import Foundation

struct ProfileModel: Codable {
  let name: String?
  let description: String?
  let website: String?
  let nfts: [String]?
  let likes: [String]?
  let id: String
  
  func update(newLikes: [String]? = nil, newNfts: [String]? = nil) -> ProfileModel {
    .init(
      name: name,
      description: description,
      website: website,
      nfts: newNfts ?? nfts,
      likes: newLikes ?? likes,
      id: id
    )
  }
}
