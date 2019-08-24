//
//  BaseViewModel.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

open class BaseViewModel<T: Model>: ViewModel {
  
  public typealias Model = T

	private let concurrency: Concurrency

  private let intents = PublishRelay<Intent>()
  private lazy var storage = {
    return intents.asObservable()
      .toReducer()
      .scan(initialState(), accumulator: { o, reducer in reducer(o) })
			.observeOn(concurrency.dispatchScheduler)
      .replay(1)
  }()
  
  public let disposeBag = CompositeDisposeBag()
  
  public init() {
		self.concurrency = ConcurrencyImp.shared
	}
	
	open func initialState() -> T {
		return Model.empty
	}
	
  open func attach() {
    // connect storage
    disposeBag += storage.connect()
  }
	
	open func detach() {
		disposeBag.clear()
	}
	
  open func state() -> Observable<SyncState> {
    return storage.map { model in
      return model.state
    }
  }
  
  open func store() -> Observable<T> {
    return storage.share()
  }
  
  open func accept(_ intent: Intent) {
    intents.accept(intent)
  }
}
