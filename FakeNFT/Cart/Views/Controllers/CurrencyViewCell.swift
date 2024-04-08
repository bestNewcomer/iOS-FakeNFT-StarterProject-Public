//
//  CurrencyViewCell.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 07.04.2024.
//

import UIKit
import Kingfisher

final class CurrencyViewCell: UICollectionViewCell, ReuseIdentifying {

    private enum Constants {
        static let imageMargin: CGFloat = 2.25
        static let leftMargin: CGFloat = 12
        static let topMargin: CGFloat = 4
        static let imageHeight: CGFloat = 36
    }

    var viewModel: CurrencyCellViewModelProtocol? {
        didSet {
            bindViewModel()
        }
    }

    private lazy var imageView = createCurrencyImageView()
    private lazy var nameLabel = createCurrencyLabel(textColor: UIColor(named: "Black")!)
    private lazy var codeLabel = createCurrencyLabel(textColor: UIColor(named: "Green")!)

    override var isSelected: Bool {
        didSet {
            layer.borderWidth = isSelected ? 1 : .zero
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindViewModel() {
        viewModel?.bind(CurrencyCellViewModelBindings(
            imageURL: { [ weak self ] in
                self?.imageView.kf.setImage(with: $0)
            },
            currencyName: { [ weak self ] in
                self?.nameLabel.text = $0
            },
            currencyCode: { [ weak self ] in
                self?.codeLabel.text = $0
            })
        )
    }
}

private extension CurrencyViewCell {
    func setupUI() {
        applyStyle()

        let labels = UIStackView(arrangedSubviews: [nameLabel, codeLabel])
        labels.axis = NSLayoutConstraint.Axis(rawValue: 1)!
        labels.alignment = UIStackView.Alignment(rawValue: 1)!
        labels.distribution = UIStackView.Distribution(rawValue: 0)!
        labels.spacing = 2

        let content = UIStackView(arrangedSubviews: [imageView, labels])
        content.axis = .horizontal
        content.alignment = .center
        content.distribution = .equalSpacing
        content.spacing = 4

        [imageView, nameLabel, codeLabel, labels, content].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        addSubview(content)

        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftMargin),
            content.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topMargin),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.leftMargin),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.topMargin),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }

    func applyStyle() {
        contentView.backgroundColor = UIColor(named: "Light Gray") 
        layer.cornerRadius = 12
        layer.masksToBounds = true
        layer.borderColor = UIColor(named: "Black")!.cgColor
        layer.borderWidth = .zero
    }

    func createCurrencyImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layoutMargins = UIEdgeInsets(
            top: Constants.imageMargin,
            left: Constants.imageMargin,
            bottom: Constants.imageMargin,
            right: Constants.imageMargin
        )
        view.backgroundColor = UIColor(named: "LightBlack")
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }

    func createCurrencyLabel(textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)!
        label.textColor = textColor
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }
}
