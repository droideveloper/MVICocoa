//
//  StringViewModel.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation


class StringViewModel: BaseViewModel<StringModel> {
  
  private let view: StringViewController
  
  init(view: StringViewController) {
    self.view = view
  }
  
  override func attach() {
    super.attach()
    
    disposeBag += view.viewEvents()
      .toIntent(view.container)
      .subscribe(onNext: accept(_ :))
  }
}
