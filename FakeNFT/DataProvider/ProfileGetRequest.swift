//
//  ProfileGetRequest.swift
//  FakeNFT
//
//  Created by Леонид Турко on 10.04.2024.
//

import Foundation

struct ProfileGetRequest: NetworkRequest {
  var endpoint = URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
}
