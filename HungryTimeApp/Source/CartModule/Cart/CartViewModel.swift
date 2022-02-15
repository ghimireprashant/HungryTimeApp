//
//  CartViewModel.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/14/22.
//

import Foundation
protocol CartViewModelDelegate: NSObjectProtocol {
  func refreshDisplay(_ viewModel: CartViewModel, reloadIndex: Int?, reloadRequired: Bool)
  func refreshAddressView(_ viewModel: CartViewModel)
}
extension CartViewModelDelegate {
  func refreshAddressView(_ viewModle: CartViewModel){}
}
// MARK: - Cart Enum
enum CartTitle: String {
  case shippingAddress = "Shipping Address"
  case cartItem = "Items"
  case coupons = "Coupons"
  case total = "Total"
}
struct CartSummary {
  var items: [Any]
  var carttTitle: CartTitle
}

class CartItemModel {
  var title: String!
  var quantity: Int!
  var totalAmount: Double!
  var amount: Double!
  var id: Int!
  init(id: Int, title: String, quantity: Int, totalAmount: Double, amount: Double) {
    self.id = id
    self.title = title
    self.quantity = quantity
    self.totalAmount = totalAmount
    self.amount = amount
  }
}
final class CartViewModel {
  var subTotal: Double = 0
  var totalAmount: Double = 0
  var vat: Double = 0
  var shippingCharge: Double = 100
  var cartItem: [CartItemModel] = []
  var addresses: [AddressDataModel]? {
    didSet {
      setUpAddress()
    }
  }
  var createdAddress: String? {
    didSet {
      self.delegate?.refreshAddressView(self)
    }
  }
  //  private let baseURL: String
  //  private let useCase: CartUseCase
  
  weak var delegate: CartViewModelDelegate?
  init(
    baseURL: String = AppConfigurations.baseURL.rawValue,
    useCase: CartUseCase = CartUseCase()
  ) {
    //    self.baseURL = baseURL
    //    self.useCase = useCase
  }
  
  /// This function will fetch data from server/json file
  func viewDidLoad() {
    //    useCase.retrieve { [weak self] result in
    //      guard let self = self else { return }
    //      switch result {
    //      case .success(let cars):
    //        self.state = .success(
    //          items: cars.map { CartItemModel(title: $0.name, quantity: 1, totalAmount: 10.0) }
    //        )
    //      case .failure:
    //        self.state = .error(message: "Error")
    //      }
    //    }
    if let data = readLocalFile(forName: "food") {
      let decoder = JSONDecoder()
      guard let foods = try? decoder.decode(Foods.self, from: data) else {
        return
      }
      self.cartItem = foods.map { CartItemModel(id: $0.id, title: $0.name, quantity: 1, totalAmount: $0.price, amount: $0.price) }
      cartCalculation()
    }
  }
  var noOfRows: Int {
    return self.cartItem.count
  }
  
  func itemAtRow(_ row: Int) -> CartItemModel {
    return cartItem[row]
  }
  /// This function will update item quantity
  /// - Parameters:
  ///   - itemIndex: Int
  ///   - updatedValue: Int
  func updateItem(itemIndex: Int, updatedValue: Int) {
    self.cartItem[itemIndex].quantity = updatedValue
    self.cartItem[itemIndex].totalAmount = Double(self.cartItem[itemIndex].quantity) * self.cartItem[itemIndex].amount
    cartCalculation(itemIndex: itemIndex)
  }
  /// This function will calculate total and refresh view using delegate
  /// - Parameters:
  ///   - itemIndex: Int
  ///   - reloadRequired: Bool
  func cartCalculation(itemIndex: Int? = nil, reloadRequired: Bool = true) {
    let cartTotal = cartItem.reduce(0, {$0 + $1.totalAmount})
    self.vat = (13/100) * cartTotal
    self.subTotal = cartTotal
    self.totalAmount = self.shippingCharge + self.vat + cartTotal
    self.delegate?.refreshDisplay(self, reloadIndex: itemIndex, reloadRequired: reloadRequired)
  }
  /// This function will setup Address view
  private func setUpAddress() {
    var addressArray: [String] = []
    guard let address = addresses else {return}
    if let object = address.first(where: {$0.textFieldType == .fullName}),  object.value != "" {
      addressArray.append(object.value)
    }
    if let object = address.first(where: {$0.textFieldType == .addressOne}),  object.value != "" {
      addressArray.append(object.value)
    }
    if let object = address.first(where: {$0.textFieldType == .addressTwo}),  object.value != "" {
      addressArray.append(object.value)
    }
    if let object = address.first(where: {$0.textFieldType == .city}),  object.value != "", let state = address.first(where: {$0.textFieldType == .state}),  state.value != "", let country = address.first(where: {$0.textFieldType == .country}),  country.value != "" {
      if let zipcode = address.first(where: {$0.textFieldType == .zipCode}),  zipcode.value != "" {
        addressArray.append(object.value + ", " + state.value + ", " + zipcode.value + ", " + country.value)
      } else {
        addressArray.append(object.value + ", " + state.value + ", " + country.value)
      }
    }
    if let object = address.first(where: {$0.textFieldType == .email}),  object.value != "" {
      addressArray.append("Email: " + object.value)
    }
    if let object = address.first(where: {$0.textFieldType == .mobileNumber}),  object.value != "" {
      addressArray.append("Mobile: " + object.value)
    }
    createdAddress = addressArray.joined(separator: "\n")
  }
  
  /// This function will fetch data from json file
  /// - Parameter name: file name
  /// - Returns: Data
  private func readLocalFile(forName name: String) -> Data? {
    do {
      if let bundlePath = Bundle.main.url(forResource: name, withExtension: "json"),
         let jsonData = try? Data(contentsOf: bundlePath) {
        return jsonData
      }
    }
    return nil
  }
}

