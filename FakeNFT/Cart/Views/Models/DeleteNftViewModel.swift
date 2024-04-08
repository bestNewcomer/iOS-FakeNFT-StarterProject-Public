//
//  DeleteNftViewModel.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 07.04.2024.
//

import Foundation

protocol DeleteNftViewModelProtocol {
    func deleteButtonDidTap()
}

final class DeleteNftViewModel: DeleteNftViewModelProtocol {
    private weak var delegate: DeleteNftDelegate?
    private var nftId: String

    init(delegate: DeleteNftDelegate, nftId: String) {
        self.delegate = delegate
        self.nftId = nftId
    }

    func deleteButtonDidTap() {
        delegate?.deleteNftDidApprove(for: nftId)
    }
}
