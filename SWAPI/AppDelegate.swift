//
//  AppDelegate.swift
//  SWAPI
//
//  Created by Blake Merryman on 1/28/17.
//  Copyright © 2017 Blake Merryman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    applyTheme()
    setupRootViewController()
    return true
  }

  /// Helper function that sets up the root view controller inside of a navigation controller.
  private func setupRootViewController() {
    let rootViewController = SWCharacterViewController()
    window?.rootViewController = UINavigationController(rootViewController: rootViewController)
    window?.makeKeyAndVisible()
  }

  /*!
   Helper function to apply a basic theme to the views.
   Specials thanks to @samcorder (Twitter) for this great helper function!
   */
  private func applyTheme() {
    UINavigationBar.appearance().barStyle = .black
    UINavigationBar.appearance().tintColor = UIColor(red:0.18,
                                                     green:0.8,
                                                     blue:0.443,
                                                     alpha:1.00)
    UINavigationBar.appearance().barTintColor = UIColor(red:0.173,
                                                        green:0.243,
                                                        blue:0.314,
                                                        alpha:1.00)
    UINavigationBar.appearance().isTranslucent = false
    UILabel.appearance().font = UIFont.preferredFont(forTextStyle: .title1)
    UILabel.appearance().textColor = .white
  }

}
