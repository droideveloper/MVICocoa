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
  
  public var container: Container? {
    get {
      if let injectable = UIApplication.shared.delegate as? Injectable {
        return injectable.container
      }
      return nil
    }
  }
  
  public func showError(_ error: Error, _ completion: (() -> Void)? = nil) {
    let sheetDialog = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .actionSheet)
    self.present(sheetDialog, animated: true, completion: completion)
  }
}
