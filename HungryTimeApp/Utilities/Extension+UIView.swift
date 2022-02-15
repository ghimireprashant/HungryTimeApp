//
//  Extension+UIView.swift
//  HungryTimeApp
//
//  Created by Prashant Ghimire on 2/14/22.
//

import Foundation
import UIKit

final class ContentSizedTableView: UITableView {
  override var contentSize:CGSize {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }
  
  override var intrinsicContentSize: CGSize {
    layoutIfNeeded()
    return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
  }
}
extension UITableView {
  /// This function will recalculate headerview size in tableview
  func layoutTableHeaderView() {
    guard let headerView = self.tableHeaderView else { return }
    headerView.translatesAutoresizingMaskIntoConstraints = false
    let headerWidth = headerView.bounds.size.width
    let temporaryWidthConstraint = headerView.widthAnchor.constraint(equalToConstant: headerWidth)
    headerView.addConstraint(temporaryWidthConstraint)
    headerView.setNeedsLayout()
    headerView.layoutIfNeeded()
    let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    let height = headerSize.height
    var frame = headerView.frame
    frame.size.height = height
    headerView.frame = frame
    self.tableHeaderView = headerView
    headerView.removeConstraint(temporaryWidthConstraint)
    headerView.translatesAutoresizingMaskIntoConstraints = true
  }
  /// This function will recalculate footerview size in tableview
  func layoutTableFooterView() {
    guard let footerView = self.tableFooterView else { return }
    footerView.translatesAutoresizingMaskIntoConstraints = false
    let footerViewWidth = footerView.bounds.size.width
    let temporaryWidthConstraint = footerView.widthAnchor.constraint(equalToConstant: footerViewWidth)
    footerView.addConstraint(temporaryWidthConstraint)
    footerView.setNeedsLayout()
    footerView.layoutIfNeeded()
    let headerSize = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    let height = headerSize.height
    var frame = footerView.frame
    frame.size.height = height
    footerView.frame = frame
    self.tableHeaderView = footerView
    footerView.removeConstraint(temporaryWidthConstraint)
    footerView.translatesAutoresizingMaskIntoConstraints = true
  }
  func updateHeaderViewHeight() {
    if let header = self.tableHeaderView {
      let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
      header.frame.size.height = newSize.height
    }
  }
  func updateFooterViewHeight() {
    if let footer = self.tableFooterView {
      let newSize = footer.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
      footer.frame.size.height = newSize.height
    }
  }
  func sizeHeaderToFit() {
    if let headerView = self.tableHeaderView {
      headerView.setNeedsLayout()
      headerView.layoutIfNeeded()
      let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
      var frame = headerView.frame
      frame.size.height = height
      headerView.frame = frame
      self.tableHeaderView = headerView
    }
  }
  func sizeFooterToFit() {
    if let footerView = self.tableFooterView {
      footerView.setNeedsLayout()
      footerView.layoutIfNeeded()
      let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
      var frame = footerView.frame
      frame.size.height = height
      footerView.frame = frame
      self.tableFooterView = footerView
    }
  }
}
protocol RequiredField {
  func setUpRequiredField()
  func removeRequiredField()
}
/// This extension is for required field in view
extension RequiredField where Self: UIView {
  /// This function will add * to view
  func setUpRequiredField() {
    let label = UILabel()
    label.tag = 201
    label.text = "*"
    label.textColor = UIColor.red
    self.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    label.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 2).isActive = true
  }
  /// This function will remove * to view
  func removeRequiredField() {
    for item in subviews where item.tag == 201 {
      item.removeFromSuperview()
    }
  }
}
