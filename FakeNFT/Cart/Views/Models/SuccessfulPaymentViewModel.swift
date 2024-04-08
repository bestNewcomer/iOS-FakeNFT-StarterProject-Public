//
//  SuccessfulPaymentViewModel.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 07.04.2024.
//

import Foundation

protocol SuccessfulPaymentViewModelProtocol {
    func bind(_ bindings: SuccessfulPaymentViewModelBindings)
    func backToCatalogDidTap()
}

final class SuccessfulPaymentViewModel: SuccessfulPaymentViewModelProtocol {
    @Observable private var isViewDismissing: Bool

    init() {
        self.isViewDismissing = false
    }

    func bind(_ bindings: SuccessfulPaymentViewModelBindings) {
        self.$isViewDismissing.bind(action: bindings.isViewDismissing)
    }

    func backToCatalogDidTap() {
        isViewDismissing = true
    }
}
