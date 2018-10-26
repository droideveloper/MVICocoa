//
//  BaseCollectionViewController.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

open class BaseCollectionViewController<T: Model, V: ViewModel>: UICollectionViewController, View where V.Model == T {
  public typealias ViewModel = V
  public typealias Model = T
  
  @IBOutlet private var refreshControl: UIRefreshControl?
  
  public lazy var viewModel: V = {
    if let viewModel = container?.resolve(V.self) {
      return viewModel
    }
    fatalError("we can not resolve view model of \(V.self)")
  }()
  
  private let events = PublishRelay<Event>()
  let disposeBag = DisposeBag()
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
    attach()
  }
  
  open func setUp() {
    // TODO do your set up
  }
  
  open func attach() {
    // base attach functionality
    viewModel.attach()
    
    if let refreshControl = refreshControl {
      // will render progress state into viewProgress instance
      disposeBag += viewModel.state()
        .map { state in
          if let state = state as? Process {
            return state == refresh
          }
          return false
        }
        .subscribe(refreshControl.rx.isRefreshing)
    }
    
    // will render view state
    disposeBag += viewModel.store()
      .subscribe(onNext: render(model:))
  }
  
  open func render(model: T) {
    // TODO implement
  }
  
  open func viewEvents() -> Observable<Event> {
    return events.share()
  }
  
  func accept(_ event: Event) {
    events.accept(event)
  }
}
