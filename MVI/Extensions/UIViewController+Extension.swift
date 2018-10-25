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

extension UIViewController {
  
  public var container: Container? {
    get {
      if let injectable = UIApplication.shared.delegate as? Injectable {
        return injectable.container
      }
      return nil
    }
  }
}
