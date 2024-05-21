//
//  CatalogСollectionViewController.swift
//  FakeNFT
//
//  Created by Леонид Турко on 09.04.2024.
//

import UIKit
import Kingfisher
import ProgressHUD

// MARK: - Protocol

protocol CatalogСollectionViewControllerProtocol: AnyObject {
  func renderViewData(viewData: CatalogCollectionViewData)
  func reloadCollectionView()
  func reloadVisibleCells()
}

// MARK: - Final Class

final class CatalogСollectionViewController: UIViewController {
  
  private var presenter: CatalogСollectionPresenterProtocol
  private var heightConstraintCV = NSLayoutConstraint()
  
  private let itemsPerRow = 3
  private let bottomMargin: CGFloat = 55
  private let cellHeight: CGFloat = 172
  
  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.showsVerticalScrollIndicator = false
    scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  private lazy var contentView: UIView = {
    let contentView = UIView()
    contentView.translatesAutoresizingMaskIntoConstraints = false
    return contentView
  }()
  
  private lazy var coverImageView: UIImageView = {
    let image = UIImageView()
    image.layer.cornerRadius = 12
    image.layer.masksToBounds = true
    image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    return image
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor =  .ypBlack
    label.font = .sfProBold22
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.textColor = .ypBlack
    label.font = .sfProRegular13
    label.text = AppStrings.CollectionVC.authorInfo
    return label
  }()
  
  private lazy var authorLink: UILabel = {
    let label = UILabel()
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(launchWebsiteViewer))
    label.isUserInteractionEnabled = true
    label.font = .sfProRegular13
    label.textColor = .ypBlueUn
    label.backgroundColor = .ypWhite
    label.addGestureRecognizer(tapGesture)
    return label
  }()
  
  private lazy var collectionDescriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = .sfProRegular13
    label.textColor = .ypBlack
    return label
  }()
  
  private lazy var nftCollection: UICollectionView = {
    let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collection.isScrollEnabled = false
    collection.dataSource = self
    collection.delegate = self
    collection.backgroundColor = .ypWhite
    collection.register(NFTCollectionCell.self)
    return collection
  }()
  
  init(presenter: CatalogСollectionPresenterProtocol) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    assertionFailure("init(coder:) has not been implemented")
    return nil
  }
  
  override func viewDidLoad() {
    presenter.viewController = self
    presenter.loadNFTs()
    setupConstraints()
    setupNavBackButton()
    presenter.presentCollectionViewData()
  }
  
  private func setupConstraints() {
    view.addSubview(scrollView)
    view.backgroundColor = .ypWhite
    
    scrollView.addSubview(contentView)
    
    [
      coverImageView,
      titleLabel,
      authorLabel,
      authorLink,
      collectionDescriptionLabel,
      nftCollection
    ].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    var topbarHeight: CGFloat {
      let statusBarHeight = navigationController?.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
      let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
      return statusBarHeight + navigationBarHeight
    }
    
    heightConstraintCV = nftCollection.heightAnchor.constraint(equalToConstant: 0)
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -topbarHeight),
      scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      
      coverImageView.heightAnchor.constraint(equalToConstant: 310),
      coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 16),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
      
      authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      authorLabel.widthAnchor.constraint(equalToConstant: 114),
      
      authorLink.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      authorLink.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: 4),
      authorLink.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      authorLink.bottomAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 1),
      authorLink.heightAnchor.constraint(equalToConstant: 28),
      
      collectionDescriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
      collectionDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      collectionDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      nftCollection.topAnchor.constraint(equalTo: collectionDescriptionLabel.bottomAnchor, constant: 24),
      nftCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      nftCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      nftCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      heightConstraintCV
    ])
  }
  
  private func setupNavBackButton() {
    navigationController?.navigationBar.tintColor = .ypBlack
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(named:"backward"),
      style: .plain,
      target: self,
      action: #selector(goBack))
  }
  
  private func calculateCollectionHeight(itemCount: Int) {
    // Вычисляем количество строк
    let numRows = (itemCount + itemsPerRow - 1) / itemsPerRow
    // Вычисляем высоту коллекции
    heightConstraintCV.constant = CGFloat(numRows) * cellHeight + bottomMargin
  }
  
  // MARK: - @objc func
  
  @objc func goBack() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func launchWebsiteViewer(_ gesture: UITapGestureRecognizer) {
    let urlString = presenter.getUserProfile()?.website ?? ""
    
    if let url = URL(string: urlString) {
      let webPresenter = WebViewPresenter()
      let webVC = WebViewController(presenter: webPresenter, url: url)
      setupNavBackButton()
      webVC.hidesBottomBarWhenPushed = true
      navigationItem.backBarButtonItem =  UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
      navigationController?.pushViewController(webVC, animated: true)
    }
  }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension CatalogСollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let itemCount = presenter.nftArray.count
    calculateCollectionHeight(itemCount: itemCount)
    return itemCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: NFTCollectionCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    let data = presenter.nftArray[indexPath.row]
    cell.setNftModel(data)
    cell.presenter = presenter
    cell.delegate = self
    cell.renderCellForModel()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: 108, height: 172)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    9
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    8
  }
}

// MARK: - NFTCollectionCellDelegate

extension CatalogСollectionViewController: NFTCollectionCellDelegate {
  func onLikeButtonTapped(cell: NFTCollectionCell) {
    guard let nftModel = cell.getNftModel() else { return }
    presenter.toggleLikeStatus(model: nftModel)
  }
  
  func addToCartButtonTapped(cell: NFTCollectionCell) {
    guard let nftModel = cell.getNftModel() else { return }
    presenter.toggleCartStatus(model: nftModel)
  }
}

// MARK: - CatalogСollectionViewControllerProtocol

extension CatalogСollectionViewController: CatalogСollectionViewControllerProtocol {
  func renderViewData(viewData: CatalogCollectionViewData) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.loadCoverImage(url: viewData.coverImageURL)
      self.titleLabel.text = viewData.title
      self.authorLink.text = viewData.authorName
      self.collectionDescriptionLabel.text = viewData.description
    }
  }
  
  func reloadVisibleCells() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      
      self.nftCollection.visibleCells.forEach { cell in
        guard let nftCell = cell as? NFTCollectionCell else {
          // Handle unexpected cell type if necessary
          return
        }
        nftCell.updateLikeButtonImage()
        nftCell.updateCartButtonImage()
      }
    }
  }
  
  
  private func loadCoverImage(url : String) {
    guard let imageUrl = URL(string: url.urlDecoder ?? "") else {
      return
    }
    coverImageView.kf.setImage(with: imageUrl)
  }
  
  func reloadCollectionView() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      
      self.nftCollection.reloadData()
    }
  }
}
