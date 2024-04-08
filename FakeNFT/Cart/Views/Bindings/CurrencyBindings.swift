//
//  CurrencyBindings.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 07.04.2024.
//

import Foundation

struct SelectCurrencyViewModelBindings {
    let isViewDismissing: ClosureBool
    let isAgreementDisplaying: ClosureBool
    //let isNetworkAlertDisplaying: ClosureBool
    let isPaymentResultDisplaying: (Bool?) -> Void
    let isCurrencyDidSelect: ClosureBool
}

struct CurrencyCellViewModelBindings {
    let imageURL: (URL?) -> Void
    let currencyName: ClosureString
    let currencyCode: ClosureString
}
