//
//  TextFieldTableViewCell.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/15/22.
//

import UIKit
protocol TextFieldTVDelegate: AnyObject {
  func didBeginEditing(cell: TextFieldTableViewCell, indexPath: IndexPath, cellType: AddressEnum)
}
class TextFieldTableViewCell: UITableViewCell {
  @IBOutlet weak var textField: RequiredDefaultTextField!
  
  var textfieldType: AddressEnum! {
    didSet {
      textField.placeholder = textfieldType.rawValue
      setUpKeyboard()
    }
  }
  var indexPath: IndexPath!
  
  weak var delegate: TextFieldTVDelegate?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      self.selectionStyle = .none
      self.textField.addTarget(self, action: #selector(didTextBeginEditing), for: .editingChanged)
    }
  private func setUpKeyboard() {
    switch textfieldType {
    case .mobileNumber:
      self.textField.keyboardType = .numberPad
    case .email:
      self.textField.keyboardType = .emailAddress
    case .zipCode:
      self.textField.keyboardType = .numbersAndPunctuation
      self.textField.isRequired = false
    case .addressTwo:
      self.textField.isRequired = false
      self.textField.keyboardType = .default
    default:
      self.textField.isRequired = true
      self.textField.keyboardType = .default
    }
  }
  @objc func didTextBeginEditing() {
      self.delegate?.didBeginEditing(cell: self, indexPath: self.indexPath, cellType: self.textfieldType)
  }

}
enum AddressEnum: String {
  case fullName = "Full Name"
  case email = "Email"
  case mobileNumber = "Mobile"
  case addressOne = "Address 1"
  case addressTwo = "Address 2"
  case city = "City"
  case state = "State"
  case country = "Country"
  case zipCode = "Zip code"
}
