//
//  OrderRequest.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 26.04.2024.
//

import Foundation

struct OrderRequest: NetworkRequest {

    let id: String

    var endpoint: URL? {
        URL(string: "https://\(RequestConstants.baseURL)/api/v1/orders/1")
    }
}

