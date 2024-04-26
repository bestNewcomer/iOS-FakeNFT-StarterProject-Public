//
//  CurrenciesRequest.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 26.04.2024.
//

import Foundation

struct CurrenciesRequest: NetworkRequest {
    
    var endpoint: URL? {
        URL(string: "https://\(RequestConstants.baseURL)/api/v1/currencies")

    }
}
