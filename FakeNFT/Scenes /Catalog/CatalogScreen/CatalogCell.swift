//
//  CatalogCell.swift
//  FakeNFT
//
//  Created by Леонид Турко on 05.04.2024.
//

import UIKit

final class CatalogCell: UITableViewCell, ReuseIdentifying {
  
  private lazy var catalogCellImage: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 12
    imageView.backgroundColor = .gray
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private lazy var catalogNameLabel: UILabel = {
    var label = UILabel()
    label.numberOfLines = 1
    label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    label.textColor = .ypBlack
    return label
  }()
  
  func setCellImage(with url: URL?) {
    self.catalogCellImage.kf.setImage(with: url)
  }
  
  func setNameLabel(with text: String) {
    self.catalogNameLabel.text = text
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    assertionFailure("init(coder:) has not been implemented")
    return nil
  }
  
  func setupUI() {
    [catalogCellImage, catalogNameLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
      contentView.backgroundColor = .ypWhite
    }
    
    NSLayoutConstraint.activate([
      catalogCellImage.heightAnchor.constraint(equalToConstant: 140),
      catalogCellImage.topAnchor.constraint(equalTo: contentView.topAnchor),
      catalogCellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      catalogCellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      catalogNameLabel.topAnchor.constraint(equalTo: catalogCellImage.bottomAnchor, constant: 4),
      catalogNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
    ])
  }
}
