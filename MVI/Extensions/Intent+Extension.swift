//
//  Intent+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public extension Intent {
  
  func toObservableNever<T>() -> Observable<T> {
    return Observable.never()
  }
  
  func toObservableError<T>(domain: String, code: Int) -> Observable<T> {
    return Observable.error(NSError(domain: domain, code: code, userInfo: nil))
  }
}

public func toFailure<T, M>(error: Error) -> Observable<Reducer<M>> where M: Model, M.Entity == T {
	let lhs: Reducer<M> = { o in o.copy(state: .failure(error), data: M.empty.data) }
	let rhs: Reducer<M> = { o in o.copy(state: .idle, data: M.empty.data) }
	return Observable.of(lhs, rhs)
}

public func toInitial<T, M>(state: Int) -> Reducer<M> where M: Model, M.Entity == T {
	return { o in o.copy(state: .operation(state, true), data: M.empty.data)}
}
