//
//  StringViewController.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation


class StringViewController: BaseViewController<StringModel, StringViewModel> {
  
  override func setUp() {
    viewProgress = UIActivityIndicatorView(style: .whiteLarge)
    viewProgress?.tintColor = UIColor.convert(0xFF0BCDEF)
  }
  
  override func render(model: StringModel) {
    if model.state is Idle {
      // idle state
    } else if model.state is Process {
      // process state
    } else if model.state is Failure {
      // failure state
      
    }
  }
}
