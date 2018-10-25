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

open class BaseViewModel<T: Model, V: View>: ViewModel where V.Model == T {
  
  public typealias View = V
  public typealias Model = T
  
  public let view: V
  
  private let intents = PublishRelay<Intent>()
  private lazy var storage = {
    return intents.asObservable()
      .toReducer()
      .observeOn(MainScheduler.instance)
      .scan(Model.empty, accumulator: { o, reducer in reducer(o) })
      .replay(1)
  }()
  
  public init(view: V) {
    self.view = view
  }
  
  let disposeBag = DisposeBag()
  
  public func attach() {
    // connect storage
    disposeBag += storage.connect()
    // register on next
    disposeBag += view.viewEvents()
      .toIntent(view.container)
      .subscribe(onNext: accept(_ :))
  }
  
  public func state() -> Observable<SyncState> {
    return storage.map { model in model.state }
  }
  
  public func store() -> Observable<T> {
    return storage.share()
  }
  
  public func accept(_ intent: Intent) {
    intents.accept(intent)
  }
}
