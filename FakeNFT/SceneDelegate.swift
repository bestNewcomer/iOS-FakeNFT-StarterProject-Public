import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      guard let windowScene = (scene as? UIWindowScene) else { return }
      let window = UIWindow(windowScene: windowScene)

      let defaults = UserDefaults.standard
      let appConfiguration = AppConfiguration()
      self.window = window
      
      window.rootViewController = TabBarController(appConfiguration: appConfiguration)
      window.makeKeyAndVisible()
  }
}
