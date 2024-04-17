//
//  CartPresenter.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 13.04.2024.
//

import Foundation
import UIKit

protocol CartPresenterProtocol {
    func totalPrice() -> Float
    func count() -> Int
    func getModel(indexPath: IndexPath) -> NftDataModel
    func sortCart(filter: CartFilter.FilterBy)
}

final class CartPresenter: CartPresenterProtocol {
    
    private weak var viewController: CartViewControllerProtocol?
    private var userDefaults = UserDefaults.standard
    private let filterKey = "filter"
    
    private var currentFilter: CartFilter.FilterBy {
        get {
            let id = userDefaults.integer(forKey: filterKey)
            return CartFilter.FilterBy(rawValue: id) ?? .id
        }
        set {
            userDefaults.setValue(newValue.rawValue, forKey: filterKey)
        }
    }

    var cartContent: [NftDataModel] = []
    var orderIds: [String] = []
    
    var mock1 = NftDataModel(createdAt: "13-04-2024", name: "mock1", images: ["mock1"], rating: 5, description: "", price: 1.78, author: "", id: "1")
    var mock2 = NftDataModel(createdAt: "13-04-2024", name: "mock2", images: ["mock2"], rating: 2, description: "", price: 1.5, author: "", id: "2")
    var mock3 = NftDataModel(createdAt: "17-04-2024", name: "mock3", images: ["mock3"], rating: 3, description: "", price: 3.5, author: "", id: "3")
    
    init(viewController: CartViewControllerProtocol) {
        self.viewController = viewController
        cartContent = [mock1, mock2, mock3]
        
    }
        
    func totalPrice() -> Float {
        var price: Float = 0
        for nft in cartContent {
            price += nft.price
        }
        return price
    }
    
    func count() -> Int {
        let count: Int = cartContent.count
        return count
    }

    func getModel(indexPath: IndexPath) -> NftDataModel {
        let model = cartContent[indexPath.row]
        return model
    }
    
    func sortCart(filter: CartFilter.FilterBy) {
        currentFilter = filter
        cartContent = cartContent.sorted(by: CartFilter.filter[currentFilter] ?? CartFilter.filterById)
        viewController?.updateCartTable()
    }
}
