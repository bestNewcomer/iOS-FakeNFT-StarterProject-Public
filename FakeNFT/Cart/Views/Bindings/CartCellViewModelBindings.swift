import Foundation

struct CartCellViewModelBindings {
    let rating: ClosureInt
    let price: ClosureDecimal
    let name: ClosureString
    let imageURL: (URL?) -> Void
}
