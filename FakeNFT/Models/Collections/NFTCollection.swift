//
//  NFTCollection.swift
//  FakeNFT
//
//  Created by Леонид Турко on 05.04.2024.
//

import Foundation

struct NFTCollection: Decodable {
  let name: String
  let cover: String
  let nfts: [String]
  let id: String
  let description: String
  let author: String
}
