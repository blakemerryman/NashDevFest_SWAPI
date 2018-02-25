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
    let characterViewController = SWCharacterViewController()
    characterViewController.title = "SWAPI"
    characterViewController.delegate = self
    window?.rootViewController = UINavigationController(rootViewController: characterViewController)
    window?.makeKeyAndVisible()
  }

  /*!
   Helper function to apply a basic theme to the views.
   Specials thanks to @samcorder (Twitter) for this great helper function!
   */
  private func applyTheme() {
    UINavigationBar.appearance().barStyle = .black
    UINavigationBar.appearance().tintColor = .yellow
    UINavigationBar.appearance().barTintColor = .black
    UINavigationBar.appearance().isTranslucent = false
    UILabel.appearance().font = UIFont.preferredFont(forTextStyle: .title1)
    UILabel.appearance().textColor = .white
  }

}

extension AppDelegate: SWCharacterViewControllerDelegate {

  func didSelect(_ character: SWCharacter, from viewController: SWCharacterViewController) {

    guard let navigationController = window?.rootViewController as? UINavigationController else {
      return // abort b/c we require a nav controller
    }

    let characterDetailsVC = SWCharacterDetailViewController(character: character)
    navigationController.pushViewController(characterDetailsVC, animated: true)
  }

}
