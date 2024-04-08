//
//  CartCellViewModelBindings.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 07.04.2024.
//

import Foundation

struct CartCellViewModelBindings {
    let rating: ClosureInt
    let price: ClosureDecimal
    let name: ClosureString
    let imageURL: (URL?) -> Void
}
