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

open class BaseTableViewController<T: Model, V: ViewModel>: UITableViewController, View where V.Model == T {
  
  public typealias ViewModel = V
  public typealias Model = T

  public var viewModel: V?
  
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
		if let viewModel = viewModel {
			// base attach functionality
			viewModel.attach()
			
			if let refreshControl = refreshControl {
				// will render progress state into viewProgress instance
				disposeBag += viewModel.state()
					.map { state in
						if let state = state as? Operation {
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
  }
  
  open func render(model: T) {
    // TODO implement
  }
	
	open override func viewWillDisappear(_ animated: Bool) {
		disposeBag.clear()
		viewModel?.detach()
		super.viewWillDisappear(animated)
	}
  
  open func viewEvents() -> Observable<Event> {
    return events.share()
  }
  
  public func accept(_ event: Event) {
    events.accept(event)
  }
}
