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
        URL(string: "https://\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    
    init(nfts: [String]) {
        self.nfts = nfts
    }
}
