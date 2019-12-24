//
//  Variable.swift
//  MVI
//
//  Created by Fatih Sen on 24.12.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public class Variable<T> where T: Equatable {
  
  private var _value: T
  
  public var value: T {
    get {
      return self._value
    }
    set(newValue) {
      if (newValue != _value) {
        self._value = newValue
        subject.onNext(self._value)
      }
    }
  }
  
  private let subject: BehaviorSubject<T>
  
  public init(value: T) {
    self._value = value
    self.subject = BehaviorSubject<T>(value: value)
  }
  
  public func asObservable() -> Observable<T> {
    return self.subject.asObserver()
  }
}
