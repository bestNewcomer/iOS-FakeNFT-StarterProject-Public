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
    guard let endpoint = URL(string: "https://d5dn3j2ouj72b0ejucbl.apigw.yandexcloud.net/api/v1/collections") else { return }
    self.endpoint = endpoint
  }
}
