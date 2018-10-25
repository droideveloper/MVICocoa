//
//  BaseViewController.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Swinject

open class BaseViewController<T: Model, V: ViewModel>: UIViewController, View where V.Model == T {
  
  public typealias ViewModel = V
  public typealias Model = T
  
  @IBOutlet private var viewProgress: UIActivityIndicatorView?
  
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
  
  public func setUp() {
    // TODO do your set up
  }
  
  public func attach() {
    // base attach functionality
    viewModel.attach()
    
    if let viewProgress = viewProgress {
      // will render progress state into viewProgress instance
      disposeBag += viewModel.state()
        .map { state in
          if let state = state as? Process {
            return state == refresh
          }
          return false
        }
        .subscribe(viewProgress.rx.isAnimating)
    }
    
    // will render view state
    disposeBag += viewModel.store()
      .subscribe(onNext: render(model:))
  }
  
  public func render(model: T) {
    // TODO implement
  }
  
  public func viewEvents() -> Observable<Event> {
    return events.share()
  }
  
  func accept(_ event: Event) {
    events.accept(event)
  }
}
