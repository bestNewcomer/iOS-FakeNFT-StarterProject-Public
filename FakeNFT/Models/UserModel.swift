//
//  UserModel.swift
//  FakeNFT
//
//  Created by Леонид Турко on 11.04.2024.
//

import Foundation

struct UserModel {
  let name: String
  let website: String
  let id: String
  
  init(with user: UserNetworkModel) {
    self.name = user.name
    self.website = user.website
    self.id = user.id
  }
}
