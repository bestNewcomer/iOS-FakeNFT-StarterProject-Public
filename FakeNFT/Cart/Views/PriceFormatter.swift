//
//  PriceFormatter.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 07.04.2024.
//

import Foundation

struct PriceFormatter {
    static let numberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        return numberFormatter
    }()

    static func formattedPrice(_ value: Float64, currency: String = "ETH") -> String {
        let format = "%@ %@"
        return String(format: format, PriceFormatter.numberFormatter.string(from: value as NSNumber) ?? "0", currency)
    }
}
