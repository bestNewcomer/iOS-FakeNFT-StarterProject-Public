//
//  NFTTableViewRequest.swift
//  FakeNFT
//
//  Created by Леонид Турко on 05.04.2024.
//

import Foundation

struct NFTTableViewRequest: NetworkRequest {
  var endpoint: URL?
  
  init() {
    guard let endpoint = URL(string: "\(RequestConstants.baseURL)/api/v1/collections") else { return }
    self.endpoint = endpoint
  }
}
