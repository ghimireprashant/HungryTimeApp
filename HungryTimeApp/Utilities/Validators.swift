//
//  Validators.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/15/22.
//

import Foundation
import UIKit.UITextField

extension UITextField {
  /// This functionw will validate textfield with validation type
  /// - Parameter validationType: ValidatorType
  /// - Throws: error
  /// - Returns: String
  func validatedText(validationType: ValidatorType) throws -> String {
    let validator = VaildatorFactory.validatorFor(type: validationType)
    return try validator.validated(self.text!)
  }
  /// This function will compair one textfield with other
  /// - Parameter textField: textfield
  /// - Throws: error
  func compairTextField( textField: UITextField) throws {
    if self.text != textField.text {
      throw ValidationError("Password didn't match.")
    }
  }
}
extension String {
  var isEmptyStr: Bool {
    return self.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
  }
  /// This functionw will validate String with validation type
  /// - Parameter validationType: ValidatorType
  /// - Throws: error
  /// - Returns: String
  func validatedText(validationType: ValidatorType) throws -> String {
    let validator = VaildatorFactory.validatorFor(type: validationType)
    return try validator.validated(self)
  }
}

class ValidationError: Error {
  var message: String
  /// Init with message
  /// - Parameter message: String
  init(_ message: String) {
    self.message = message
  }
}

protocol ValidatorConvertible {
  func validated(_ value: String) throws -> String
}

enum ValidatorType {
  // MARK: - Validation type
  case email
  case requiredField(field: String)
  case mobileNumber
}
enum VaildatorFactory {
  /// This function will validate fields
  /// - Parameter type: ValidatorType
  /// - Returns: ValidatorConvertible
  static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
    switch type {
    case .email: return EmailValidator()
    case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
    case .mobileNumber: return MobileNumberValidator()
    }
  }
}

// MARK: - Required Field Validation
struct RequiredFieldValidator: ValidatorConvertible {
  private let fieldName: String
  init(_ field: String) {
    fieldName = field
  }
  func validated(_ value: String) throws -> String {
    //    guard !value.isEmpty else {
    //      throw ValidationError("Required field " + fieldName)
    //    }
    guard value != "" else {throw ValidationError("Please enter " + fieldName.lowercased())}
    return value
  }
}

// MARK: - Email Validation
struct EmailValidator: ValidatorConvertible {
  func validated(_ value: String) throws -> String {
    do {
      if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
        throw ValidationError("Please enter a valid email.")
      }
    } catch {
      if value != "" {throw ValidationError("Please enter a valid email.")} else {
        throw ValidationError("Please enter a valid email.")
      }
    }
    return value
  }
}

// MARK: - Phone Number Validation
struct MobileNumberValidator: ValidatorConvertible {
  func validated(_ value: String) throws -> String {
    guard value.count >= 10 else {throw ValidationError("Please enter a valid mobile (or phone) number.")}
    return value
  }
}
