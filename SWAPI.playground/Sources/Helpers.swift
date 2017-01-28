import UIKit
import PlaygroundSupport

/// JSON encoder/decoder helper structure. 
public struct JSONHelper: JSONEncoderDecoder {
  public static let shared = JSONHelper()
  private init() {}
}

/// Helper function to ensure the playground is configured for async network activity.
public func prepareForNetworkActivity() {
  PlaygroundPage.current.needsIndefiniteExecution = true
  URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
}

/*:
 Helper function to apply a basic theme to the views.
 Specials thanks to @samcorder (Twitter) for this great helper function!
 */
public func applyTheme() {
  UINavigationBar.appearance().barStyle = .black
  UINavigationBar.appearance().tintColor = UIColor(red:0.18, green:0.8, blue:0.443, alpha:1.00)
  UINavigationBar.appearance().barTintColor = UIColor(red:0.173, green:0.243, blue:0.314, alpha:1.00)
  UINavigationBar.appearance().isTranslucent = false
  UILabel.appearance().font = UIFont.preferredFont(forTextStyle: .title1)
  UILabel.appearance().textColor = .white
}

/*:
 Helper function to present the view controller as a live view in the Assistant Editor window.
 Specials thanks to @samcorder (Twitter) for this great helper function!
 */
public func presentViewController(controller: UIViewController) {
  applyTheme()
  let navController = UINavigationController(rootViewController: controller)
  PlaygroundPage.current.needsIndefiniteExecution = true
  PlaygroundPage.current.liveView = navController
}
