//
//  ChangeOrderRequest.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 18.04.2024.
//

import Foundation

struct ChangeOrderRequest: NetworkRequest {
    
    var httpMethod: HttpMethod { .put }
    var nfts: [String]?
    
    var endpoint: URL? {
        var urlComponents = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
        var components: [URLQueryItem] = []
        
        if let nfts = self.nfts {
          for nft in nfts {
            components.append(URLQueryItem(name: "nfts", value: nft))
          }
        } else {
            components.append(URLQueryItem(name: "nfts", value: ""))
        }
        
        
        
        urlComponents?.queryItems = components
        return urlComponents?.url
    }
    
    var isUrlEncoded: Bool {
      return true
    }
    
    var dto: Encodable?
    
    let token = "107f0274-8faf-4343-b31f-c12b62673e2f"
    
    init(nfts: [String]) {
        self.nfts = nfts
    }
}
