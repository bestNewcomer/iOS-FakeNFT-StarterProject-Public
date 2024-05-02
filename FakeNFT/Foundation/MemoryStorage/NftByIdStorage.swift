//
//  NftByIdStorage.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 26.04.2024.
//

import Foundation

protocol NftByIdStorageProtocol: AnyObject {
    var storage: [String: NftDataModel] {get}
    
    func saveNftById(_ nftById: NftDataModel)
    func getNftById(with id: String) -> NftDataModel?
    func removeNftById(with id: String)
    func removeAllNft()
}

final class NftByIdStorage: NftByIdStorageProtocol{

    internal var storage: [String: NftDataModel] = [:]

    private let syncQueue = DispatchQueue(label: "sync-order-queue")

    func saveNftById(_ nftById: NftDataModel) {
        syncQueue.async { [weak self] in
            self?.storage[nftById.id] = nftById
        }
    }

    func getNftById(with id: String) -> NftDataModel? {
        syncQueue.sync {
            storage[id]
        }
    }
    
    func removeNftById(with id: String) {
        syncQueue.sync {
            storage[id] = nil
        }
    }
    
    func removeAllNft() {
        syncQueue.sync {
            storage = [:]
        }
    }
}
