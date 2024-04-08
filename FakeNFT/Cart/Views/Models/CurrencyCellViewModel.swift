//
//  CurrencyCellViewModel.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 07.04.2024.
//

import Foundation

protocol CurrencyCellViewModelProtocol {
    func bind(_ bindings: CurrencyCellViewModelBindings)
}

final class CurrencyCellViewModel: CurrencyCellViewModelProtocol {

    @Observable private var imageURL: URL?
    @Observable private var currencyName: String = ""
    @Observable private var currencyCode: String = ""

    private var currencyId: String = ""

    func bind(_ bindings: CurrencyCellViewModelBindings) {
        self.$imageURL.bind(action: bindings.imageURL)
        self.$currencyName.bind(action: bindings.currencyName)
        self.$currencyCode.bind(action: bindings.currencyCode)
    }
}
