import Foundation

protocol SelectCurrencyViewModelProtocol: AlertServiceDelegate {
    var selectedCurrency: String? {get set}
    
    func viewDidLoad()
    func bind(_ bindings: SelectCurrencyViewModelBindings)
    func backButtonDidTap()
    func userAgreementDidTap()
    func didSelectCurrency(_ currency: String)
    func pullToRefreshDidTrigger()
    func payButtonDidTap()
}

final class SelectCurrencyViewModel: SelectCurrencyViewModelProtocol {
    @Observable private var currencyList: [CartCurrency]
    @Observable private var isViewDismissing: Bool
    @Observable private var isAgreementDisplaying: Bool
    @Observable private var isNetworkAlertDisplaying: Bool
    @Observable private var isPaymentResultDisplaying: Bool?
    @Observable private var isCurrencySelected: Bool

    var selectedCurrency: String?

    init() {
        self.currencyList = []
        self.selectedCurrency = ""
        self.isViewDismissing = false
        self.isAgreementDisplaying = false
        self.isNetworkAlertDisplaying = false
        self.isCurrencySelected = false
    }

    func backButtonDidTap() {
        isViewDismissing = true
    }
    
    func payButtonDidTap() {
        guard let selectedCurrency else { return }
    }
    
    func pullToRefreshDidTrigger() {
        
    }


    func viewDidLoad() {
        
    }

    func bind(_ bindings: SelectCurrencyViewModelBindings) {
        self.$currencyList.bind(action: bindings.currencyList)
        self.$isViewDismissing.bind(action: bindings.isViewDismissing)
        self.$isAgreementDisplaying.bind(action: bindings.isAgreementDisplaying)
        self.$isCurrencySelected.bind(action: bindings.isCurrencySelected)
    }

    func userAgreementDidTap() {
        isAgreementDisplaying = true
    }

    func didSelectCurrency(_ currency: String) {
        selectedCurrency = currency
        isCurrencySelected = true
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
