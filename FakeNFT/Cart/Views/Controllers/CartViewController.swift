//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Ruth Dayter on 03.04.2024.
//

import UIKit
import ProgressHUD

protocol DeleteNftDelegate: AnyObject {
    func deleteNftDidApprove(for id: String)
}

final class CartViewController: UIViewController, DeleteNftDelegate {
    func deleteNftDidApprove(for id: String) {
        //TODO
    }
    

    var viewModel: CartViewModelProtocol? {
        didSet {
            bindViewModel()
        }
    }
    private let layoutMargin: CGFloat = 16
    private lazy var nftCountLabel = createCountLabel()
    private lazy var nftPriceTotalLabel = createPriceTotalLabel()
    private lazy var nftCartTableView = createTableView()
    private lazy var nftPaymentView = createPaymentView()
    private lazy var emptyCartPlaceholderView = createEmptyCartPlaceholder()
    
    private var mock1 = CartNftInfo(name: "MockPic1", imageURLString: "", rating: 5, price: 1.78, id: "1")
    private var mock2 = CartNftInfo(name: "MockPic2", imageURLString: "", rating: 3, price: 1.11, id: "2")

    private var nftCount: Int = .zero
    private var nftPriceTotal: Float64 = .zero
    var nftList: [CartNftInfo] = []
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.viewWillAppear()
        bindViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel?.viewDidLoad()
        self.nftCartTableView.dataSource = self
        self.nftCartTableView.reloadData()
    }
    
    @objc private func pullToRefreshDidTrigger() {
        //viewModel?.pullToRefreshDidTrigger()
    }

    private func bindViewModel() {
        print("binding")
        let numberOfNftBinding = { [weak self] in
            guard let self else { return }
            self.nftCount = $0
            self.displayNftCount()
        }
        let priceTotalBinding = { [weak self] in
            guard let self else { return }
            self.nftPriceTotal = $0
            self.displayPriceTotal()
        }

        let nftListBinding: ([CartNftInfo]) -> Void = { [weak self] in
            guard let self else { return }
            //TODO: исправить на реальные данные
            self.nftList = $0
            //self.nftCartTableView.reloadData()
            self.nftCartTableView.refreshControl?.beginRefreshing()
            self.nftCartTableView.refreshControl?.sendActions(for: .valueChanged)
            print(self.nftCartTableView.refreshControl?.isRefreshing == true, "aha")
            if self.nftCartTableView.refreshControl?.isRefreshing == true {
                self.nftCartTableView.refreshControl?.endRefreshing()
            }
            ProgressHUD.dismiss()
        }
        /*let networkAlertDisplayBinding = { [weak self] isNetworkAlertDisplaying in
            guard let self else { return }
            if isNetworkAlertDisplaying {
                ProgressHUD.dismiss()
                if self.nftCartTableView.refreshControl?.isRefreshing == true {
                    self.nftCartTableView.refreshControl?.endRefreshing()
                }
            }
        }*/
        let paymentScreenDisplayBinding = { [weak self] isPaymentScreenDisplaying in
            if isPaymentScreenDisplaying {
                self?.presentPaymentViewController()
            }
        }
        let bindings = CartViewModelBindings(
            numberOfNft: numberOfNftBinding,
            priceTotal: priceTotalBinding,
            nftList: nftListBinding,
            isEmptyCartPlaceholderDisplaying: {[weak self] _ in
                
                var emp = self?.isEmpty() ?? true
                
                self?.displayEmptyCartPlaceholder(!emp)
                
                
            },
            //isNetworkAlertDisplaying: networkAlertDisplayBinding,
            isPaymentScreenDisplaying: paymentScreenDisplayBinding
        )
        viewModel?.bind(bindings)
    }
    
    func isEmpty() -> Bool {
        return nftList.count == 0
    }

    private func presentPaymentViewController() {
        let paymentController = SelectCurrencyViewController()
        let viewModel = SelectCurrencyViewModel()
        paymentController.viewModel = viewModel
        //TODO
        //paymentController.onBackToCartViewController = backToCartViewController
        paymentController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(paymentController, animated: true)
    }

    private func displayEmptyCartPlaceholder(_ isPlaceHolderVisible: Bool) {
        emptyCartPlaceholderView.isHidden = !isPlaceHolderVisible
        nftCartTableView.isHidden = isPlaceHolderVisible
        nftPaymentView.isHidden = isPlaceHolderVisible
        navigationController?.isNavigationBarHidden = isPlaceHolderVisible
    }

    private func presentSortViewController() {

        let title = "Сортировка"
        let priceItemTitle = "По цене"
        let ratingItemTitle = "По рейтингу"
        let nameItemTitle = "По названию"
        let cancelItemTitle = "Закрыть"

    }

}

// MARK: UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nftCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartViewCell = tableView.dequeueReusableCell()

        let nft = nftList[indexPath.item]
        cell.viewModel = CartCellViewModel(delegate: self, nftId: nft.id)
        cell.viewModel?.cellReused(for: nft)

        return cell
    }
}

// MARK: CartCellDelegate
extension CartViewController: CartCellDelegate {
    func deleteButtonDidTap(for nftId: String, with image: Any?, imageURL: URL?) {
        let viewModel = DeleteNftViewModel(delegate: self, nftId: nftId)
        let controller = DeleteNftViewController(viewModel: viewModel, image: image as? UIImage, imageURL: imageURL)
        controller.modalPresentationStyle = UIModalPresentationStyle(rawValue: 5)!
        controller.modalTransitionStyle = UIModalTransitionStyle(rawValue: 2)!
        present(controller, animated: true)
    }
}

// MARK: UITableViewDelegate
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            guard let cell = tableView.cellForRow(at: indexPath) as? CartViewCell else { return }
            cell.viewModel?.deleteButtonDidTap(image: nil)
        }
    }
}

// MARK: Setup UI & Layout
private extension CartViewController {
    func setupUI() {
        view.backgroundColor = UIColor(named: "White")
        //setupProgress()

        let sortButton = UIBarButtonItem(
            image: UIImage(named: "Sort") ?? UIImage(),
            style: .plain,
            target: self,
            //TODO
            action: #selector(sortButtonDidTap)
        )
        sortButton.tintColor = UIColor(named: "Black")
        navigationItem.rightBarButtonItem = sortButton

        view.addSubview(nftCartTableView)
        view.addSubview(nftPaymentView)
        displayNftCount()
        displayPriceTotal()

        NSLayoutConstraint.activate([
            nftCartTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nftCartTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nftCartTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nftCartTableView.bottomAnchor.constraint(equalTo: nftPaymentView.topAnchor),

            nftPaymentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nftPaymentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nftPaymentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nftPaymentView.heightAnchor.constraint(equalToConstant: 76)
        ])

        view.addSubview(emptyCartPlaceholderView)
        NSLayoutConstraint.activate([
            emptyCartPlaceholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCartPlaceholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        displayEmptyCartPlaceholder(isEmpty())
    }

    func setupProgress() {
        ProgressHUD.animationType = .systemActivityIndicator
        ProgressHUD.colorHUD = UIColor(named: "Black") ?? .black
        ProgressHUD.colorAnimation = UIColor(named: "Light Gray")!
        ProgressHUD.show()
    }

    func createTableView() -> UITableView {
        let table = UITableView()
        table.separatorStyle = .none
        table.allowsSelection = false
        table.backgroundColor = UIColor(named: "White")
        table.delegate = self
        table.dataSource = self
        table.register(CartViewCell.self)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshDidTrigger), for: .valueChanged)
        table.refreshControl = refreshControl
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }

    func displayPriceTotal() {
        nftPriceTotalLabel.text = PriceFormatter.formattedPrice(nftPriceTotal)
    }

    func displayNftCount() {
        nftCountLabel.text = "\(nftCount) NFT"
        print("\(nftCount) NFT")
    }

    func createPaymentView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Light Gray")
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false

        let labelView = UIStackView(arrangedSubviews: [nftCountLabel, nftPriceTotalLabel])
        labelView.axis = NSLayoutConstraint.Axis(rawValue: 1)!
        labelView.alignment = UIStackView.Alignment(rawValue: 1)!
        labelView.spacing = 2
        labelView.distribution = UIStackView.Distribution(rawValue: 1)!
        labelView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelView)

        let button = RoundedButton(
            title: "К оплате"
        )
        //TODO
        //button.addTarget(self, action: #selector(payButtonDidTap), for: .touchUpInside)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: layoutMargin),
            labelView.topAnchor.constraint(equalTo: view.topAnchor, constant: layoutMargin),
            labelView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -layoutMargin),

            button.widthAnchor.constraint(equalToConstant: 240),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: layoutMargin),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -layoutMargin),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -layoutMargin)
        ])
        return view
    }

    func createCountLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 15)
        label.textColor = UIColor(named: "Black")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func createPriceTotalLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Bold", size: 17)
        label.textColor = UIColor(named: "Green")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func createEmptyCartPlaceholder() -> UIView {
        let view = UILabel()
        view.text = "Корзина пуста"
        view.font = UIFont(name: "SFProText-Bold", size: 17)
        view.textColor = UIColor(named: "Black")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    @objc private func sortButtonDidTap() {
        //TODO
    }
}
