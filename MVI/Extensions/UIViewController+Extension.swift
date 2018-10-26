//
//  UIViewController+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import Alamofire

extension UIViewController {
  
  private var contentFramTag: Int {
    get {
      return 0xFF
    }
  }
  
  public var container: Container? {
    get {
      if let injectable = UIApplication.shared.delegate as? Injectable {
        return injectable.container
      }
      return nil
    }
  }
  
  public func showError(_ error: Error, _ style: UIAlertController.Style = .actionSheet,  _ completion: (() -> Void)? = nil) {
    let sheetDialog = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: style)
    self.present(sheetDialog, animated: true, completion: completion)
  }
  
  public func attachTo(parentViewController: UIViewController) {
    parentViewController.addChild(self)
    if let view = parentViewController.view.viewWithTag(contentFramTag) {
      self.view.frame = view.bounds
      view.addSubview(self.view)
      self.didMove(toParent: parentViewController)
    } else {
      fatalError("you should have container that containing ")
    }
  }
  
  public func detachFromParentViewController() {
    self.willMove(toParent: nil)
    self.view.removeFromSuperview()
    self.removeFromParent()
  }
}
