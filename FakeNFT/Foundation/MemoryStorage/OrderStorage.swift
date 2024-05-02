//
//  OrderStorage.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 18.04.2024.
//

import Foundation

protocol OrderStorageProtocol: AnyObject {
    func saveOrder(_ order: OrderDataModel)
    func getOrder(with id: String) -> OrderDataModel?
    func removeOrder()
}

final class OrderStorage: OrderStorageProtocol {

    private var storage: [String: OrderDataModel] = [:]

    private let syncQueue = DispatchQueue(label: "sync-order-queue")

    func saveOrder(_ order: OrderDataModel) {
        syncQueue.async { [weak self] in
            self?.storage[order.id] = order
        }
    }

    func getOrder(with id: String) -> OrderDataModel? {
        syncQueue.sync {
            storage[id]
        }
    }
    
    func removeOrder() {
        syncQueue.sync {
            storage = [:]
        }
    }
}
