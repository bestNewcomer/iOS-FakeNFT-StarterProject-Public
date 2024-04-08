//
//  SelectCurrencyViewModel.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 07.04.2024.
//

import Foundation

protocol SelectCurrencyViewModelProtocol {
    func viewDidLoad()
    func bind(_ bindings: SelectCurrencyViewModelBindings)
    func backButtonDidTap()
    func userAgreementDidTap()
    func didSelectCurrency(_ currency: String)
}

final class SelectCurrencyViewModel: SelectCurrencyViewModelProtocol {
    @Observable private var isViewDismissing: Bool
    @Observable private var isAgreementDisplaying: Bool
    @Observable private var isNetworkAlertDisplaying: Bool
    @Observable private var isPaymentResultDisplaying: Bool?
    @Observable private var isCurrencyDidSelect: Bool

    private var selectedCurrency: String?

    init() {
        self.isViewDismissing = false
        self.isAgreementDisplaying = false
        self.isNetworkAlertDisplaying = false
        self.isCurrencyDidSelect = false
    }

    func backButtonDidTap() {
        isViewDismissing = true
    }

    func viewDidLoad() {
    }

    func bind(_ bindings: SelectCurrencyViewModelBindings) {
        self.$isViewDismissing.bind(action: bindings.isViewDismissing)
        self.$isAgreementDisplaying.bind(action: bindings.isAgreementDisplaying)
        //self.$isNetworkAlertDisplaying.bind(action: bindings.isNetworkAlertDisplaying)
        self.$isPaymentResultDisplaying.bind(action: bindings.isPaymentResultDisplaying)
        self.$isCurrencyDidSelect.bind(action: bindings.isCurrencyDidSelect)
    }

    func userAgreementDidTap() {
        isAgreementDisplaying = true
    }

    func didSelectCurrency(_ currency: String) {
        selectedCurrency = currency
        isCurrencyDidSelect = true
    }

    private func paymentResultDidReceive(_ result: Result<Bool, Error>) {
        switch result {
        case .success(let isPaymentSuccessful):
            self.isPaymentResultDisplaying = isPaymentSuccessful
        case .failure:
            isNetworkAlertDisplaying = true
        }
    }

    private func networkFailureDidGet() {
        isNetworkAlertDisplaying = true
    }
}
