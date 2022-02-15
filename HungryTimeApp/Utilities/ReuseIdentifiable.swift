//
//  ReuseIdentifiable.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/12/22.
//

import Foundation
import UIKit
protocol ReuseIdentifiable {
  static var identifier: String { get }
}

extension ReuseIdentifiable {
  static var identifier: String {
    return String(describing: Self.self)
  }
}
extension UITableViewCell: ReuseIdentifiable {
}
