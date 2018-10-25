//
//  DisposeBag+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

extension DisposeBag {
  
  public static func += (disposeBag: DisposeBag, d: Disposable) {
    disposeBag.insert(d)
  }
}
