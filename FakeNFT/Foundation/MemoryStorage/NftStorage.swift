import Foundation

protocol NftStorageProtocol: AnyObject {
    func saveNft(_ nft: Nft)
    func getNft(with id: String) -> Nft?
}

final class NftStorage: NftStorageProtocol {
    private var storage: [String: Nft] = [:]

    func saveNft(_ nft: Nft) {
        storage[nft.id] = nft
    }

    func getNft(with id: String) -> Nft? {
        storage[id]
    }
}
