//
//  OrderDataModel.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 18.04.2024.
//

import Foundation

struct OrderDataModel: Decodable {
    var nfts: [String]
    var id: String
}
