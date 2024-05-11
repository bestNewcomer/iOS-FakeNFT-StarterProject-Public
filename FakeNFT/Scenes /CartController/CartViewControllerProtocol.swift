//
//  CartViewControllerProtocol.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 13.04.2024.
//

import Foundation

protocol CartViewControllerProtocol: AnyObject {
    func showPlaceholder()
    func updateCartTable()
    func startLoadIndicator()
    func stopLoadIndicator()
}
