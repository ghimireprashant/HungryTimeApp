//
//  Stepper.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/14/22.
//

import Foundation
import UIKit
protocol StepperDelegate: NSObjectProtocol {
  func didChangeStepperValue(_ inView: Stepper, action: StepperActionType)
}
enum StepperActionType {
  case add, minus, delete
}

class Stepper: UIView {
  let nibName = "Stepper"
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var addBtn: UIButton!
  @IBOutlet weak var minusBtn: UIButton!
  @IBOutlet weak var currentValueLabel: UILabel!
  
  weak var delegate: StepperDelegate?
  
  var currentValue: Int = 1 {
    didSet {
      valueChanged()
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  func commonInit() {
    guard let view = loadViewFromNib() else { return }
    view.frame = self.bounds
    self.addSubview(view)
    self.layer.cornerRadius = 8
    self.layer.masksToBounds = true
    self.backgroundColor = .clear
    valueChanged()
  }
  
  func loadViewFromNib() -> UIView? {
    let nib = UINib(nibName: nibName, bundle: nil)
    return nib.instantiate(withOwner: self, options: nil).first as? UIView
  }
  private func valueChanged() {
    let animation = CATransition()
    animation.timingFunction = CAMediaTimingFunction(name:
                                                      CAMediaTimingFunctionName.easeInEaseOut)
    animation.type = CATransitionType.fade
    animation.duration = 0.4
    self.currentValueLabel.layer.add(animation, forKey: CATransitionType.fade.rawValue)
    self.currentValueLabel.text = currentValue.description
  }
  // MARK: - ButtonAction
  @IBAction func addAction(_ sender: Any) {
    currentValue += 1
    self.delegate?.didChangeStepperValue(self, action: .add)
  }
  @IBAction func minusAction(_ sender: Any) {
    guard currentValue > 1 else {
      self.delegate?.didChangeStepperValue(self, action: .delete)
      return
    }
    currentValue -= 1
    self.delegate?.didChangeStepperValue(self, action: .minus)
  }
}
