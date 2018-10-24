//
//  Intent+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

extension Intent {
  
  public func toObservableNever<T>() -> Observable<T> {
    return Observable.never()
  }
  
  public func toObservableError<T>(domain: String, code: Int) -> Observable<T> {
    return Observable.error(NSError(domain: domain, code: code, userInfo: nil))
  }
}
