//
//  Observable+Intent.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

extension Observable where Element == Intent {
  
  public func toReducer<T>() -> Observable<Reducer<T>> {
    return self.concatMap { intent -> Observable<Reducer<T>> in
      if let intent = intent as? ReducerIntent<T> {
        return intent.toObservableIntent()
      } else if let intent = intent as? ObservableIntent<T> {
        return intent.invoke()
      }
      return intent.toObservableNever()
    }
  }
}
