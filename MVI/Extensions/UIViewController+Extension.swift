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
import SwinjectStoryboard

import Alamofire

public extension UIViewController {
  
  private var contentFramTag: Int {
    get {
      return 0xFF
    }
  }
  
  var container: Container? {
    get {
      if let injectable = UIApplication.shared.delegate as? Injectable {
        return injectable.container
      }
      return nil
    }
  }
  
  func showError(_ error: Error, _ style: UIAlertController.Style = .actionSheet,  _ completion: (() -> Void)? = nil) {
    let sheetDialog = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: style)
    sheetDialog.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in sheetDialog.dismiss(animated: true, completion: nil) }))
    self.present(sheetDialog, animated: true, completion: completion)
  }
  
  func attachTo(parentViewController: UIViewController) {
    parentViewController.addChild(self)
    if let view = parentViewController.view.viewWithTag(contentFramTag) {
      self.view.frame = view.bounds
      view.addSubview(self.view)
      self.didMove(toParent: parentViewController)
    } else {
      fatalError("you should have container that containing ")
    }
  }
	
	func storyboard(name: String = "Main") -> SwinjectStoryboard {
    guard let container = self.container else {
      fatalError("Container not found")
    }
    return SwinjectStoryboard.create(name: name, bundle: Bundle.main, container: container)
  }
  
	///
	/// Controllers created through here will be injected with Swinject and
	/// their name conventions should be same as their class name in
	/// stroyboard identifier for sanity of system
	///
  func instantiateFromStoryboardHelper<T>(_ name: String = "Main", type: T.Type) -> T {
    let storyboard = self.storyboard(name: name)
    let identifier = String(describing: type) // controller identifier should be matching with class name
    let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! T
    return controller
  }
  
  func detachFromParentViewController() {
    self.willMove(toParent: nil)
    self.view.removeFromSuperview()
    self.removeFromParent()
  }
}
