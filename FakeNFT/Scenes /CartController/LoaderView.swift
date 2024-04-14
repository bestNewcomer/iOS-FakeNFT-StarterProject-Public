//
//  LoaderView.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 13.04.2024.
//

import UIKit

final class LoaderView: UIView, LoadingView {

    var activityIndicator = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(activityIndicator)
        activityIndicator.constraintCenters(to: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
