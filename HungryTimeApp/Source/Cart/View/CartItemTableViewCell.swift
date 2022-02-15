//
//  CartItemTableViewCell.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/14/22.
//

import UIKit
protocol CartItemTVDelegate: NSObjectProtocol {
  func didUpdateStepper(inCell: CartItemTableViewCell, item: CartItemModel, action: StepperActionType)
}
class CartItemTableViewCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var stepperView: Stepper!
  @IBOutlet weak var totalPriceLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  weak var delegate: CartItemTVDelegate?
  var item: CartItemModel! {
    didSet {
      titleLabel.text = item.title
      priceLabel.text = item.amount.doubleValue
      totalPriceLabel.text = item.totalAmount.doubleValue
      stepperView.currentValue = item.quantity
      iconImageView.image = self.tag % 2 == 0 ? UIImage(named: "iconNonVeg"): UIImage(named: "iconVeg")
      self.stepperView.delegate = self
    }
  }

  class func nib() -> UINib {
    return UINib(nibName: CartItemTableViewCell.identifier, bundle: nil)
  }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      self.selectionStyle = .none
    }
}
extension CartItemTableViewCell: StepperDelegate {
  func didChangeStepperValue(_ inView: Stepper, action: StepperActionType) {
    self.delegate?.didUpdateStepper(inCell: self, item: item, action: action)
  }
}
