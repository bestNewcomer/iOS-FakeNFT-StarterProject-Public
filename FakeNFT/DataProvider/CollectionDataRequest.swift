//
//  CollectionDataRequest.swift
//  FakeNFT
//
//  Created by Леонид Турко on 10.04.2024.
//

import Foundation

struct CollectionDataRequest: NetworkRequest {
  
  var endpoint: URL?
  
  init(id: String) {
    guard let endpoint = URL(string: "\(RequestConstants.baseURL)/api/v1/collections/\(id)") else { return }
    self.endpoint = endpoint
  }
}
