import Foundation

import UIKit
import ProgressHUD

final class SelectCurrencyViewController: UIViewController {

    private enum Constants {
        static let cellInterimSpacing: CGFloat = 7
        static let cellLineSpacing: CGFloat = 7
        static let cellHeight: CGFloat = 46
        static let cellsInRow: Int = 2
        static let collectionLeftMargin: CGFloat = 16
        static let collectionTopMargin: CGFloat = 20
        static let paymentViewHeight: CGFloat = 186
    }

    var viewModel: SelectCurrencyViewModelProtocol? {
        didSet {
            bindViewModel()
        }
    }

    var onBackToCartViewController: (() -> Void)?

    private var currencyList: [CartCurrency] = []
    private lazy var alertService = createAlertService()
    private lazy var currencyCollectionView = createCurrencyCollectionView()
    private lazy var payButton = createPayButton()
    var mock1 = CartCurrency(title: "Bitcoin", name: "BTC", id: "1")
    var mock2 = CartCurrency(title: "Thether", name: "USDT", id: "2")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel?.viewDidLoad()
        currencyList = [mock1, mock2]
        currencyCollectionView.delegate = self
        currencyCollectionView.dataSource = self

    }

    @objc private func backButtonDidTap() {
        viewModel?.backButtonDidTap()
    }

    @objc private func userAgreementDidTap() {
        viewModel?.userAgreementDidTap()
    }
    
    @objc private func payButtonDidTap() {
        //viewModel?.payButtonDidTap()
        if viewModel?.selectedCurrency == "1" {
            alertService?.presentGenericErrorAlert()
        } else {
            let viewModel = SuccessfulPaymentViewModel()
            let controller = SuccessfulPaymentViewController(viewModel: viewModel)
            controller.onBackToCartViewController = onBackToCartViewController
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @objc private func pullToRefreshDidTrigger() {
        viewModel?.pullToRefreshDidTrigger()
    }

    private func bindViewModel() {
        let currencyListBinding = { [ weak self ] in
            guard let self else { return }
            self.currencyList = $0
            self.currencyCollectionView.reloadData()
            self.currencyCollectionView.refreshControl?.endRefreshing()
            ProgressHUD.dismiss()
        }
        let viewDismissBinding = { [ weak self ] in
            if $0 {
                self?.onBackToCartViewController?()
                self?.navigationController?.popViewController(animated: true)
            }
        }

        let bindings = SelectCurrencyViewModelBindings(
            currencyList: currencyListBinding,
            isViewDismissing: viewDismissBinding,
            isAgreementDisplaying: { [ weak self ] in
                if $0 {
                    self?.presentAgreement()
                }
            },
            isCurrencySelected: { [ weak self ] in
                self?.payButton.isEnabled = $0
            })
        viewModel?.bind(bindings)
    }

    private func presentAgreement() {
        let viewModel = AgreementViewModel()
        let controller = AgreementViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func createAlertService() -> AlertServiceProtocol? {
        guard let viewModel else { return nil }
        let alertService = DefaultAlertService(delegate: viewModel, controller: self)
        return alertService
    }
}

extension SelectCurrencyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCurrency = currencyList[indexPath.item].id
        viewModel?.didSelectCurrency(selectedCurrency)
    }
}

extension SelectCurrencyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currencyList.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: CurrencyViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)

        let currency = currencyList[indexPath.item]
        cell.viewModel = CurrencyCellViewModel()
        cell.viewModel?.cellReused(for: currency)
        return cell
    }
}

private extension SelectCurrencyViewController {
    func setupUI() {
        view.backgroundColor = UIColor(named: "White")

        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonDidTap)
        )
        backButton.tintColor = UIColor(named: "Black")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Выберите способ оплаты"
        navigationItem.titleView?.tintColor = UIColor(named: "Black")

        view.addSubview(currencyCollectionView)

        let paymentView = createPaymentView()
        view.addSubview(paymentView)

        NSLayoutConstraint.activate([
            currencyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currencyCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currencyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currencyCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            paymentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paymentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paymentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            paymentView.heightAnchor.constraint(equalToConstant: Constants.paymentViewHeight)
        ])
        //setupProgress()
    }

    func createCurrencyCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection(rawValue: 1)!
        layout.minimumInteritemSpacing = Constants.cellInterimSpacing
        layout.minimumLineSpacing = Constants.cellLineSpacing
        layout.sectionInset = UIEdgeInsets(
            top: Constants.collectionTopMargin,
            left: Constants.collectionLeftMargin,
            bottom: Constants.collectionTopMargin,
            right: Constants.collectionLeftMargin
        )
        let rowEmptySpace = Constants.collectionLeftMargin * CGFloat(2) + Constants.cellInterimSpacing
        let cellWidth = (view.bounds.width - rowEmptySpace) / CGFloat(Constants.cellsInRow)
        layout.itemSize = CGSize(width: cellWidth, height: Constants.cellHeight)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshDidTrigger), for: .valueChanged)
        collection.refreshControl = refreshControl
        collection.backgroundColor = UIColor(named: "White")
        collection.register(CurrencyViewCell.self)
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }

    private func createPayButton() -> RoundedButton {
        let button = RoundedButton(title: "Оплатить")
        button.isEnabled = false
        button.addTarget(self, action: #selector(payButtonDidTap), for: .touchUpInside)
        return button
    }

    func createPaymentView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Light Gray") 
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = UIColor(named: "Black")
        label.textAlignment = .left
        label.text = "Совершая покупку, вы соглашаетесь с условиями"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        let link = UIButton()
        link.setTitle("Пользовательского соглашения", for: .normal)
        link.setTitleColor(UIColor(named: "Blue"), for: .normal)
        link.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 13)
        link.titleLabel?.textAlignment = .left
        link.addTarget(self, action: #selector(userAgreementDidTap), for: .touchUpInside)
        link.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(link)
        view.addSubview(payButton)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.collectionLeftMargin),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.collectionLeftMargin),

            link.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.collectionLeftMargin),
            link.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),

            payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.collectionLeftMargin),
            payButton.topAnchor.constraint(equalTo: link.bottomAnchor, constant: 20),
            payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.collectionLeftMargin),
            payButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        return view
    }

    func setupProgress() {
        ProgressHUD.animationType = .systemActivityIndicator
        ProgressHUD.colorHUD = UIColor(named: "Black")!
        ProgressHUD.colorAnimation = UIColor(named: "Light Gray")!
        ProgressHUD.show()
    }
}
