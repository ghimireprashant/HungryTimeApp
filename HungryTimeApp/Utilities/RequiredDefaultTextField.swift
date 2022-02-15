//
//  RequiredDefaultTextField.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/15/22.
//

import Foundation
import UIKit

class RequiredDefaultTextField: UITextField, RequiredField {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  @IBInspectable var isRequired: Bool = false {
    didSet {
      setup()
    }
  }
  @IBInspectable var placeholderTextColor: UIColor = UIColor.gray {
    didSet {
      setup()
    }
  }
  var padding = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
  
  @IBInspectable var left: CGFloat = 8 {
    didSet {
      adjustPadding()
    }
  }
  
  @IBInspectable var right: CGFloat = 0 {
    didSet {
      adjustPadding()
    }
  }
  
  @IBInspectable var top: CGFloat = 0 {
    didSet {
      adjustPadding()
    }
  }
  
  @IBInspectable var bottom: CGFloat = 0 {
    didSet {
      adjustPadding()
    }
  }
  fileprivate func setup() {
    if isRequired {
      setUpRequiredField()
    } else {
      removeRequiredField()
    }
    tintColor = UIColor.gray
    attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder!: "", attributes: [NSAttributedString.Key.foregroundColor: placeholderTextColor])
  }
  func adjustPadding() {
    padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
  }
}
