//
//  AddressViewController.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/15/22.
//

import UIKit

struct AddressDataModel {
  var textFieldType: AddressEnum
  var value: String = ""
  init(textFieldType: AddressEnum) {
    self.textFieldType = textFieldType
  }
  static func getAddress() -> [AddressDataModel] {
    return [AddressDataModel(textFieldType: .fullName), AddressDataModel(textFieldType: .email), AddressDataModel(textFieldType: .addressOne), AddressDataModel(textFieldType: .addressTwo), AddressDataModel(textFieldType: .mobileNumber), AddressDataModel(textFieldType: .country), AddressDataModel(textFieldType: .state), AddressDataModel(textFieldType: .city), AddressDataModel(textFieldType: .zipCode) ]
  }
}
protocol AddressViewControllerDelegate: NSObjectProtocol {
  func didChangeAddress(addresses: [AddressDataModel]?)
}
class AddressViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet var tableViewFooterView: UIView!
  var addressDataSource: [AddressDataModel]?
  weak var delegate: AddressViewControllerDelegate?

  // MARK: - View Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    if addressDataSource == nil {
      addressDataSource = AddressDataModel.getAddress()
    }
    self.navigationItem.title = "User Detail"
    self.tableView.reloadData()
    setUpTable()
  }
  /// This function will setUp tableview
  private func setUpTable() {
    self.tableView.tableFooterView = tableViewFooterView
    self.tableView.updateFooterViewHeight()
  }
  /// This function will validate textfield
  /// - Returns: Bool
  private func validateTextField() -> Bool {
    self.view.endEditing(true)
    let requiredField: [AddressEnum] = [.fullName, .email, .addressOne, .mobileNumber, .country, .state, .city]
    
    for item in addressDataSource! where requiredField.contains(item.textFieldType) {
      switch item.textFieldType {
        
      case .mobileNumber:
        do {
          _ = try item.value.validatedText(validationType: .mobileNumber)
        } catch let error as ValidationError {
          showNormalAlert(for: error.message)
          return false
        } catch {
        }
      case .email:
        do {
          _ = try item.value.validatedText(validationType: .email)
        } catch let error as ValidationError {
          showNormalAlert(for: error.message)
          return false
        } catch {
        }
      default:
        do {
          _ = try item.value.validatedText(validationType: .requiredField(field: item.textFieldType.rawValue))
        } catch let error as ValidationError {
          showNormalAlert(for: error.message)
          return false
        } catch {
        }
        
      }
    }
    return true
  }
  // MARK: - Button Action
  @IBAction func saveAction(_ sender: Any) {
    guard validateTextField() else {return}
    self.delegate?.didChangeAddress(addresses: addressDataSource)
    self.navigationController?.popViewController(animated: true)
  }
  
}
// MARK: - TableView DataSource
extension AddressViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return addressDataSource?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =
    tableView.dequeueReusableCell(
      withIdentifier: TextFieldTableViewCell.identifier,
      for: indexPath
    ) as! TextFieldTableViewCell
    cell.delegate = self
    cell.indexPath = indexPath
    cell.textField.text = self.addressDataSource?[indexPath.row].value
    cell.textfieldType = self.addressDataSource?[indexPath.row].textFieldType
    return cell
    
  }
}
// MARK: - Textfield TableView Delegate
extension AddressViewController: TextFieldTVDelegate {
  func didBeginEditing(cell: TextFieldTableViewCell, indexPath: IndexPath, cellType: AddressEnum) {
    self.addressDataSource?[indexPath.row].value = cell.textField.text ?? ""
  }
}
