//
//  Observable+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {
  
  public func async() -> Observable<Element> {
    return self.subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
      .observeOn(MainScheduler.instance)
  }
}
