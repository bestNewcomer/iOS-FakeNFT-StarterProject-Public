import UIKit

final class TabBarController: UITabBarController {

    var servicesAssembly: ServicesAssembly!

    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
        tag: 0
    )
    
    private var mock1 = CartNftInfo(name: "MockPic1", imageURLString: "", rating: 5, price: 1.78, id: "1")
    private var mock2 = CartNftInfo(name: "MockPic2", imageURLString: "", rating: 3, price: 1.11, id: "2")
    
    override func viewWillAppear(_ animated: Bool) {
        let cartViewController = CartViewController()
        let cartViewModel = CartViewModel()
        cartViewController.viewModel = cartViewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let catalogController = TestCatalogViewController(
            servicesAssembly: servicesAssembly
        )
        
        let cartViewController = CartViewController()
        let cartViewModel = CartViewModel()
        cartViewController.viewModel = cartViewModel
        cartViewController.viewModel?.nftList = [mock1, mock2]
        let cartNavigationController = UINavigationController(rootViewController: cartViewController)
        cartNavigationController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Корзина", comment: ""),
            image: UIImage(named: "Cart"),
            tag: 2
        )
        
        catalogController.tabBarItem = catalogTabBarItem

        viewControllers = [catalogController, cartNavigationController]

        view.backgroundColor = .systemBackground
    }
}
