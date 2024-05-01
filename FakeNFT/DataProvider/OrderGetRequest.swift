//
//  OrderGetRequest.swift
//  FakeNFT
//
//  Created by Леонид Турко on 12.04.2024.
//

import Foundation

struct OrderGetRequest: NetworkRequest {
  var endpoint = URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
}
