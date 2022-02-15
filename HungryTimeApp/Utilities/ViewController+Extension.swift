//
//  ViewController+Extension.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/12/22.
//

import Foundation
import UIKit

extension UIViewController: ReuseIdentifiable {
  /// This function will show alert
  /// - Parameters:
  ///   - alert: message String
  ///   - completionHandler: succes button completionHandler
  func showNormalAlert(for alert: String? = "", completionHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.alert)
        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString(string: alert ?? "", attributes: attrs)
        alertController.setValue(attributedString, forKey: "attributedMessage")
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { (alert) in
          completionHandler?()
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)

  }
  /// This function will show alert
  /// - Parameters:
  ///   - title: title
  ///   - meesage: message
  ///   - negative: nagative button text
  ///   - positive: positive button text
  ///   - completionHandler: completionHandler
  func showAlertWith(for title: String? = nil, meesage: String? = nil, negative: String, positive: String, completionHandler: (() -> Void)? = nil) {
    let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
    let attributedString = NSMutableAttributedString(string: meesage ?? "", attributes: attrs)
    let alertController = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.alert)
    alertController.setValue(attributedString, forKey: "attributedMessage")
    alertController.addAction(UIAlertAction(title: positive, style: .default, handler: { (action: UIAlertAction!) in
      completionHandler?()
    }))
    alertController.addAction(UIAlertAction(title: negative, style: .cancel, handler: { (action: UIAlertAction!) in
    }))
    present(alertController, animated: true, completion: nil)
  }
}

extension Double {
  var doubleValue: String {
    return String(format: "NRs %.2f", self)
  }
}
