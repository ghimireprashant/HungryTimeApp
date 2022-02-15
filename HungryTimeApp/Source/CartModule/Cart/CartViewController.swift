//
//  CartViewController.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/12/22.
//

import UIKit

class CartViewController: UIViewController {
  var viewModel: CartViewModel!
  @IBOutlet weak var tableViewHeaderView: UIView!
  @IBOutlet var tableViewFooterView: UIView!
  
  //  init(
  //    viewModel: CartViewModel
  //  ) {
  //    self.viewModel = viewModel
  //    super.init(nibName: nil, bundle: nil)
  //    self.viewModel.delegate = self
  //  }
  //
  //  required init?(
  //    coder: NSCoder
  //  ) {
  //    fatalError("init(coder:) has not been implemented")
  //  }
  @IBOutlet weak var addressLabel: UILabel!
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var subTotalLabel: UILabel!
  @IBOutlet weak var shippingChargeValue: UILabel!
  @IBOutlet weak var vatLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var shippingAddressView: UIView!
  
  // MARK: - View Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.navigationItem.title = "Your Cart"
    viewModel = CartViewModel()
    viewModel.delegate = self
    viewModel.viewDidLoad()
    tableViewSetUp()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.tableView.setContentOffset(.zero, animated: true)
    }
  }
  /// This function will register tableview cell
  private func tableViewSetUp() {
    self.tableView.register(CartItemTableViewCell.nib(), forCellReuseIdentifier: CartItemTableViewCell.identifier)
    self.tableView.tableFooterView = self.tableViewFooterView
    self.tableView.tableHeaderView = self.tableViewHeaderView
    self.tableView.layoutTableHeaderView()
    self.tableView.sizeFooterToFit()
  }
  /// This function will push viewcontroller to shipping view
  private func showShippingAddress() {
    let storboard = UIStoryboard(name: "Cart", bundle: nil)
    let viewController = storboard.instantiateViewController(withIdentifier: AddressViewController.identifier) as! AddressViewController
    viewController.delegate = self
    viewController.addressDataSource = self.viewModel.addresses
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  // MARK: - Button/View Action
  @IBAction func shippingAddressAction(_ sender: Any) {
    showShippingAddress()
  }
  @IBAction func paymentAction(_ sender: Any) {
    if self.viewModel.addresses == nil {
      showNormalAlert(for: "Please Add Shipping Address") {
        self.showShippingAddress()
      }
    }
  }
}
// MARK: - Cart ViewModel Delegate
extension CartViewController: CartViewModelDelegate {
  func refreshDisplay(_ viewModel: CartViewModel, reloadIndex: Int?, reloadRequired: Bool) {
    DispatchQueue.main.async {
      if reloadRequired {
        if let index = reloadIndex {
          self.tableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .fade)
        } else {
          self.tableView.reloadData()
        }
      }
      self.totalLabel.text = self.viewModel.totalAmount.doubleValue
      self.shippingChargeValue.text = self.viewModel.shippingCharge.doubleValue
      self.vatLabel.text = self.viewModel.vat.doubleValue
      self.subTotalLabel.text = self.viewModel.subTotal.doubleValue
    }
  }
  
  func refreshAddressView(_ viewModel: CartViewModel) {
    if let address = viewModel.createdAddress {
      self.shippingAddressView.isHidden = false
      self.addressLabel.text = address
      self.tableView.layoutTableHeaderView()
    }
  }
}
// MARK: - TableView DataSource
extension CartViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.noOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =
    tableView.dequeueReusableCell(
      withIdentifier: CartItemTableViewCell.identifier,
      for: indexPath
    ) as! CartItemTableViewCell
    cell.item = viewModel.itemAtRow(indexPath.row)
    cell.tag = indexPath.row
    cell.delegate = self
    return cell
    
  }
}
// MARK: - Address ViewController Delegate
extension CartViewController: AddressViewControllerDelegate {
  func didChangeAddress(addresses: [AddressDataModel]?) {
    self.viewModel.addresses = addresses
  }
}
// MARK: - Cart Item TableView Cell Delegate
extension CartViewController: CartItemTVDelegate {
  func didUpdateStepper(inCell: CartItemTableViewCell, item: CartItemModel, action: StepperActionType) {
    switch action {
    case .delete:
      guard self.viewModel.cartItem.count > 7 else {
        showNormalAlert(for: "7 items are required in the cart as a minimum.", completionHandler: nil)
        return
      }
      if let indexToRemove = self.viewModel.cartItem.firstIndex(where: {$0.id == item.id}) {
        let indexPath = IndexPath(item: indexToRemove, section: 0)
        self.viewModel.cartItem.remove(at: indexToRemove)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.viewModel.cartCalculation(reloadRequired: false)
      }
    default:
      self.viewModel.updateItem(itemIndex: inCell.tag, updatedValue: inCell.stepperView.currentValue)
    }
  }
}
