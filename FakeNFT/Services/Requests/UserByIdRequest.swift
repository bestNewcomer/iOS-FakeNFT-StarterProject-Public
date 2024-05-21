//
//  UserByIdRequest.swift
//  FakeNFT
//
//  Created by Леонид Турко on 11.04.2024.
//

import Foundation

struct UserByIdRequest: NetworkRequest {
  var endpoint: URL?
  
  init(id: String) {
    guard let endpoint = URL(string:
                              "\(RequestConstants.baseURL)/api/v1/users/\(id)") else { return }
    self.endpoint = endpoint
  }
}
