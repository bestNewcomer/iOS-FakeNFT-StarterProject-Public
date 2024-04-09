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
