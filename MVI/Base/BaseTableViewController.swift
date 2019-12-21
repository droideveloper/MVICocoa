//
//  BaseTableViewController.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

open class BaseTableViewController<T: Model, V: ViewModel>: UITableViewController, Loggable where V.Model == T {

  public var viewModel: V!
  
  private let events = PublishRelay<Event>()
  public let disposeBag = CompositeDisposeBag()
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }
	
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    attach()
  }
  
  open func setUp() {
    // TODO do your set up
  }
  
  open func attach() {
		// base attach functionality
    viewModel.attach()

    // will render view state
    disposeBag += viewModel.store()
      .subscribe(onNext: render(model:))
    
    guard let refreshControl = refreshControl else {
      log(.error, "\(UIRefreshControl.self) is not available in context")
      return // we must return if we do not want it to execute
    }
    
    disposeBag += viewModel.state()
      .map { state in state ~> SyncState.refresh }
      .subscribe(refreshControl.rx.isRefreshing)
  }
  
  open func render(model: T) { /*no opt*/ }
	
  open func detach() {
    disposeBag.clear()
    viewModel.detach()
  }
	
  open override func viewWillDisappear(_ animated: Bool) {
    detach()
    super.viewWillDisappear(animated)
  }
  
  open func viewEvents() -> Observable<Event> {
    return events.share()
  }
  
  public func accept(_ event: Event) {
    events.accept(event)
  }
}
