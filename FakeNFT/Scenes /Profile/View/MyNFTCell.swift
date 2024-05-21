//
//  MyNFTCell.swift
//  FakeNFT
//
//  Created by Ринат Шарафутдинов on 04.04.2024.
//

import UIKit
import Kingfisher

protocol MyNFTCellDelegate: AnyObject {
    func didTapLikeButton(nftID: String)
}

final class MyNFTCell: UITableViewCell {
    
    // MARK: - Public Properties
    static let cellID = "MyNFTCell"
    weak var delegate: MyNFTCellDelegate?
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "ypBlack")
        label.font = UIFont.sfProBold17
        return label
    }()
    
    lazy var fromLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "ypBlack")
        label.text = "от"
        label.font = UIFont.sfProRegular15
        return label
    }()
    
    lazy var holderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "ypBlack")
        label.font = UIFont.sfProRegular13
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "ypBlack")
        label.text = "Цена"
        label.font = UIFont.sfProRegular13
        return label
    }()
    
    lazy var ethLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "ypBlack")
        label.font = UIFont.sfProBold17
        return label
    }()
    
    lazy var nftImage: UIImageView = {
        let imVi = UIImageView()
        imVi.contentMode = .scaleAspectFit
        imVi.backgroundColor = UIColor(named: "ypBlueUn")
        imVi.layer.cornerRadius = 12
        imVi.clipsToBounds = true
        return imVi
    }()
    
    lazy var ratingImage: SpecialRatingView = {
        let imVi = SpecialRatingView()
        return imVi
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = UIColor(named: "ypWhite")
        button.addTarget(self, action: #selector(tapLikeButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private Properties
    private var id: String?
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 35
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var fromStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 2
        return stackView
    }()
    
    
    
    // MARK: - Initializers
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        customizingScreenElements()
        customizingTheLayoutOfScreenElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    @objc func tapLikeButton() {
        if let id = id {
            delegate?.didTapLikeButton(nftID: id)
        }
    }
    
    // MARK: - Public Methods
    func changingNFT(nft: NFT) {
        
        if let nftImageURLString = nft.images.first,
           let nftImageURL = URL(string: nftImageURLString) {
            nftImage.kf.setImage(with: nftImageURL)
        } else {
            nftImage.image = UIImage(named: "avatar")
        }
        nameLabel.text = nft.name
        ratingImage.ratingVisualization(rating: nft.rating)
        ethLabel.text = String(format: "%.2f", nft.price) + " ETH"
        holderLabel.text = nft.author
    }
    
    func setIsLiked(isLiked: Bool) {
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeButton.tintColor = isLiked ? UIColor(named: "ypRedUn"): UIColor(named: "ypWhite")
    }
    
    // MARK: - Private Methods
    private func customizingScreenElements() {
        [nftImage, infoStackView, likeButton, priceStackView].forEach {contentView.addSubview($0)}
        [nameStackView].forEach {infoStackView.addArrangedSubview($0)}
        [priceLabel, ethLabel].forEach {priceStackView.addArrangedSubview($0)}
        [nameLabel, ratingImage.view, fromStackView].forEach {nameStackView.addArrangedSubview($0)}
        [fromLabel, holderLabel].forEach {fromStackView.addArrangedSubview($0)}
    }
    
    private func customizingTheLayoutOfScreenElements() {
        [nftImage, infoStackView, likeButton, priceStackView, fromStackView, nameLabel].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
        
        NSLayoutConstraint.activate([
            nftImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nftImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImage.heightAnchor.constraint(equalToConstant: 108),
            nftImage.widthAnchor.constraint(equalToConstant: 108),
            
            infoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: nftImage.trailingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -23),
            infoStackView.heightAnchor.constraint(equalToConstant: 62),
            
            likeButton.topAnchor.constraint(equalTo: nftImage.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: nftImage.trailingAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            
            priceStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: infoStackView.trailingAnchor),
            priceStackView.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 10),
            
            fromStackView.widthAnchor.constraint(equalToConstant: 58),
            nameLabel.widthAnchor.constraint(equalToConstant: 78)
        ])
    }
}

