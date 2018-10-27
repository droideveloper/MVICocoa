//
//  Intent.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public protocol Intent {}
class EmptyIntent: Intent { }

open class ReducerIntent<T>: Intent {
	
	public init() { } // to make it visible for overriding
	
  open func invoke() -> Reducer<T> {
    return { model in model } // does nothing just sends back model as its
  }
}

open class ObservableIntent<T>: Intent {
	
	public init() { } // to make it visible for overriding
	
  open func invoke() -> Observable<Reducer<T>> {
    return Observable.empty() // does nothing just send empty observable
  }
}

public typealias Reducer<T> = (T) -> T
