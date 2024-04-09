import Foundation

struct SelectCurrencyViewModelBindings {
    let currencyList: ([CartCurrency]) -> Void
    let isViewDismissing: ClosureBool
    let isAgreementDisplaying: ClosureBool
    let isCurrencySelected: ClosureBool
}

struct CurrencyCellViewModelBindings {
    let imageURL: (URL?) -> Void
    let currencyName: ClosureString
    let currencyCode: ClosureString
}
