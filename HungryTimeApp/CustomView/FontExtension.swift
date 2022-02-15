//
//  FontExtension.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/15/22.
//

import Foundation
import UIKit
extension UIDevice {
  var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }
  var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
  var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
  enum ScreenType: String {
    case iPhones_4_4S = "iPhone 4 or iPhone 4S"
    case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
    case iPhones_6_6s_7_8_SE2 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
    case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
    case iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus Simulators"
    case iPhones_X_XS_12MiniSimulator = "iPhone X or iPhone XS or iPhone 12 Mini Simulator"
    case iPhone_XR_11 = "iPhone XR or iPhone 11"
    case iPhone_XSMax_ProMax = "iPhone XS Max or iPhone Pro Max"
    case iPhone_11Pro = "iPhone 11 Pro"
    case iPhone_12Mini = "iPhone 12 Mini"
    case iPhone_12_12Pro = "iPhone 12 or iPhone 12 Pro"
    case iPhone_12ProMax = "iPhone 12 Pro Max"
    case unknown
  }
  var screenType: ScreenType {
    switch UIScreen.main.nativeBounds.height {
    case 1136: return .iPhones_5_5s_5c_SE
    case 1334: return .iPhones_6_6s_7_8_SE2
    case 1792: return .iPhone_XR_11
    case 1920: return .iPhones_6Plus_6sPlus_7Plus_8Plus
    case 2208: return .iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators
    case 2340: return .iPhone_12Mini
    case 2426: return .iPhone_11Pro
    case 2436: return .iPhones_X_XS_12MiniSimulator
    case 2532: return .iPhone_12_12Pro
    case 2688: return .iPhone_XSMax_ProMax
    case 2778: return .iPhone_12ProMax
    default: return .unknown
    }
  }
}
enum FontType: Int {
  case title = 1
  case title2 = 2
  case address = 3
  case itemTitle = 4
  case common = 5
  case defaultFont = 10
  case button = 20
  case bigFont = 30
  
  var customFont: UIFont {
    switch self {
      
    case .title:
      switch UIDevice.current.screenType {
      case .iPhones_4_4S:
        return UIFont.systemFont(ofSize: 15, weight: .bold)
      case .iPhones_5_5s_5c_SE:
        return UIFont.systemFont(ofSize: 15, weight: .bold)
      case .iPhones_6_6s_7_8_SE2:
        return UIFont.systemFont(ofSize: 16, weight: .bold)
      case .iPhones_6Plus_6sPlus_7Plus_8Plus:
        return UIFont.systemFont(ofSize: 17, weight: .bold)
      case .iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators:
        return UIFont.systemFont(ofSize: 17, weight: .bold)
      case .iPhones_X_XS_12MiniSimulator:
        return UIFont.systemFont(ofSize: 18, weight: .bold)
      case .iPhone_XR_11:
        return UIFont.systemFont(ofSize: 18, weight: .bold)
      case .iPhone_XSMax_ProMax:
        return UIFont.systemFont(ofSize: 18, weight: .bold)
      case .iPhone_11Pro:
        return UIFont.systemFont(ofSize: 18, weight: .bold)
      case .iPhone_12Mini:
        return UIFont.systemFont(ofSize: 18, weight: .bold)
      case .iPhone_12_12Pro:
        return UIFont.systemFont(ofSize: 18, weight: .bold)
      case .iPhone_12ProMax:
        return UIFont.systemFont(ofSize: 18, weight: .bold)
      case .unknown:
        return UIFont.systemFont(ofSize: 14, weight: .bold)
      }
    case .title2:
      switch UIDevice.current.screenType {
      case .iPhones_4_4S:
        return UIFont.systemFont(ofSize: 13, weight: .semibold)
      case .iPhones_5_5s_5c_SE:
        return UIFont.systemFont(ofSize: 13, weight: .semibold)
      case .iPhones_6_6s_7_8_SE2:
        return UIFont.systemFont(ofSize: 14, weight: .semibold)
      case .iPhones_6Plus_6sPlus_7Plus_8Plus:
        return UIFont.systemFont(ofSize: 15, weight: .semibold)
      case .iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators:
        return UIFont.systemFont(ofSize: 15, weight: .semibold)
      case .iPhones_X_XS_12MiniSimulator:
        return UIFont.systemFont(ofSize: 15, weight: .semibold)
      case .iPhone_XR_11:
        return UIFont.systemFont(ofSize: 15, weight: .semibold)
      case .iPhone_XSMax_ProMax:
        return UIFont.systemFont(ofSize: 15, weight: .semibold)
      case .iPhone_11Pro:
        return UIFont.systemFont(ofSize: 15, weight: .semibold)
      case .iPhone_12Mini:
        return UIFont.systemFont(ofSize: 15, weight: .semibold)
      case .iPhone_12_12Pro:
        return UIFont.systemFont(ofSize: 15, weight: .semibold)
      case .iPhone_12ProMax:
        return UIFont.systemFont(ofSize: 15, weight: .semibold)
      case .unknown:
        return UIFont.systemFont(ofSize: 15, weight: .semibold)
      }
    case .address:
      switch UIDevice.current.screenType {
      case .iPhones_4_4S:
        return UIFont.systemFont(ofSize: 12, weight: .medium)
      case .iPhones_5_5s_5c_SE:
        return UIFont.systemFont(ofSize: 12, weight: .medium)
      case .iPhones_6_6s_7_8_SE2:
        return UIFont.systemFont(ofSize: 12, weight: .medium)
      case .iPhones_6Plus_6sPlus_7Plus_8Plus:
        return UIFont.systemFont(ofSize: 13, weight: .medium)
      case .iPhones_6Plus_6sPlus_7Plus_8Plus_Simulators:
        return UIFont.systemFont(ofSize: 13, weight: .medium)
      case .iPhones_X_XS_12MiniSimulator:
        return UIFont.systemFont(ofSize: 13, weight: .medium)
      case .iPhone_XR_11:
        return UIFont.systemFont(ofSize: 13, weight: .medium)
      case .iPhone_XSMax_ProMax:
        return UIFont.systemFont(ofSize: 13, weight: .medium)
      case .iPhone_11Pro:
        return UIFont.systemFont(ofSize: 13, weight: .medium)
      case .iPhone_12Mini:
        return UIFont.systemFont(ofSize: 13, weight: .medium)
      case .iPhone_12_12Pro:
        return UIFont.systemFont(ofSize: 13, weight: .medium)
      case .iPhone_12ProMax:
        return UIFont.systemFont(ofSize: 13, weight: .medium)
      case .unknown:
        return UIFont.systemFont(ofSize: 13, weight: .medium)
      }
    case .itemTitle:
      return UIFont.systemFont(ofSize: 15, weight: .medium)
      
    case .common:
      return UIFont.systemFont(ofSize: 13, weight: .regular)
    case .defaultFont:
      return UIFont.systemFont(ofSize: 13, weight: .regular)
    case .button:
      return UIFont.systemFont(ofSize: 18, weight: .regular)
    case .bigFont:
      return UIFont.systemFont(ofSize: 20, weight: .semibold)
      
    }
  }
  static func getFont(rawValue: Int) -> UIFont {
    if let fontType = FontType(rawValue: rawValue) {
      return fontType.customFont
    }
    return FontType.defaultFont.customFont
  }
}

@IBDesignable
extension UILabel {
  @IBInspectable public var textFont: Int {
    set {
      self.font = FontType.getFont(rawValue: newValue)
    }
    get {
      return 0
    }
  }
}
@IBDesignable
extension UITextField {
  
  @IBInspectable public var textFonts: Int {
    set {
      self.font = FontType.getFont(rawValue: newValue)
    }
    get {
      return 0
    }
  }
}
@IBDesignable
extension UIButton {
  @IBInspectable public var textFonts: Int {
    set {
      self.titleLabel!.font = FontType.getFont(rawValue: newValue)
    }
    get {
      return 0
    }
  }
}

