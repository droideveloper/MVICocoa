//
//  ReducerIntent<T>+Extensions.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public extension ReducerIntent {
  
  func toObservableIntent() -> Observable<Reducer<T>> {
    return Observable.of(self.invoke())
  }
}
