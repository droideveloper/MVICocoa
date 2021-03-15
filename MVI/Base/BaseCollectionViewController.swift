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

open class BaseCollectionViewController<T: Model, V: ViewModel>: UICollectionViewController where V.Model == T {
	
  public var viewModel: V!
  
	private lazy var events = {
		return PublishRelay<Event>()
	}()
	
	public lazy var disposeBag = {
		return CompositeDisposeBag()
	}()
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }
	
	open override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		attach()
	}
  
  open func setUp() { /* no opt*/ }
  
  open func attach() {
		// base attach functionality
		viewModel.attach()

		// will render view state
		disposeBag += viewModel.store()
			.subscribe(onNext: render(model:))
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
