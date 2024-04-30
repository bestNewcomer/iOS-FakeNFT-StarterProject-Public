import UIKit

final class TabBarController: UITabBarController {
  
  let appConfiguration: AppConfiguration
  var servicesAssembly: ServicesAssembly!
  
  init(appConfiguration: AppConfiguration) {
    self.appConfiguration = appConfiguration
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    self.appConfiguration = AppConfiguration()
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let profileViewController = ProfileViewController(servicesAssembly: servicesAssembly)
    

    let profilePresenter = ProfilePresenter()
    profileViewController.presenter = profilePresenter
    profilePresenter.view = profileViewController
    
    //to present a future hierarchy of view controllers in tab bar interface
    let catalogNC = UINavigationController(
      rootViewController: appConfiguration.catalogViewController)
    
    catalogNC.tabBarItem = UITabBarItem(
      title: NSLocalizedString("Tab.catalog", comment: ""),
      image: UIImage(named:"catalogBar"),
      tag: 1
    )
    
    let profileTabBarItem = UITabBarItem(
        title: "Профиль",
        image: UIImage(named: "profileBar"),
        tag: 0
    )
    
    let profileNavigationController = UINavigationController(rootViewController: profileViewController)
    profileViewController.tabBarItem = profileTabBarItem
    
    viewControllers = [profileNavigationController, catalogNC]
    
    tabBar.isTranslucent = false
    view.tintColor = .ypBlueUn
    tabBar.backgroundColor = .ypWhite
    tabBar.unselectedItemTintColor = .ypBlack
    tabBar.tintColor = .ypBlack
    
    if #available(iOS 15.0, *) {
      let appearance = UITabBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = .ypWhite
      appearance.shadowColor = nil
      appearance.stackedLayoutAppearance.normal.iconColor = .ypBlack
      appearance.stackedLayoutAppearance.selected.iconColor = .ypBlueUn
      tabBar.standardAppearance = appearance
      tabBar.scrollEdgeAppearance = appearance

    
    
    
    
   
    
    

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let profileViewController = ProfileViewController(servicesAssembly: servicesAssembly)
//        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
//        profileViewController.tabBarItem = profileTabBarItem
//
//        let profilePresenter = ProfilePresenter()
//        profileViewController.presenter = profilePresenter
//        profilePresenter.view = profileViewController
//        
//        viewControllers = [profileNavigationController]
//
//        view.backgroundColor = .systemBackground
    }
  }
}
