//
//  CartBindings.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 07.04.2024.
//

import Foundation

struct CartViewModelBindings {
    let numberOfNft: ClosureInt
    let priceTotal: ClosureDecimal
    let nftList: ([CartNftInfo]) -> Void
    let isEmptyCartPlaceholderDisplaying: ClosureBool
    //let isNetworkAlertDisplaying: ClosureBool
    let isPaymentScreenDisplaying: ClosureBool
}
