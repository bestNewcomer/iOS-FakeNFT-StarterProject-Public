//
//  PayRequest.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 26.04.2024.
//

import Foundation

struct PayRequest: NetworkRequest {
    
    let currencyId: String
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1/payment/\(currencyId)")
    }
    
    var nfts: [String]?
}
