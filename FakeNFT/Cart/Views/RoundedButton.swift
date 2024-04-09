//
//  RoundedButton.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 07.04.2024.
//

import UIKit

final class RoundedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }

    private func applyStyle() {
        backgroundColor = UIColor(named: "Black")
        layer.cornerRadius = 16
        layer.masksToBounds = true
        titleLabel?.font = UIFont(name: "SFProText-Bold", size: 17)
        setTitleColor(UIColor(named: "White"), for: .normal)
        setTitleColor(UIColor(named: "White")!.withAlphaComponent(0.5), for: .disabled)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

