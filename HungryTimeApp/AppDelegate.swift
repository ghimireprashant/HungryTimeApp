//
//  AppDelegate.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    self.window = UIWindow(frame: UIScreen.main.bounds)
    if #available(iOS 13, *) { } else {
      loadInitalViewController()
    }
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  // MARK: - appdelegate insatance
  class func shared() -> AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate
  }
}
func loadInitalViewController() {
  var mainWindow: UIWindow?
  if #available(iOS 13.0, *) {
    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    mainWindow = (windowScene?.delegate as? SceneDelegate)?.window
  } else {
    mainWindow = AppDelegate.shared()?.window
  }
//  let viewController = HomeViewController(nibName: HomeViewController.identifier, bundle: nil)
//  mainWindow?.rootViewController = viewController
//  mainWindow?.makeKeyAndVisible()
  let storboard = UIStoryboard(name: "Cart", bundle: nil)
  let viewController = storboard.instantiateViewController(withIdentifier: CartViewController.identifier) as! CartViewController
  
  let navigationController = UINavigationController(rootViewController: viewController)
  mainWindow?.rootViewController = navigationController
  mainWindow?.makeKeyAndVisible()
}
