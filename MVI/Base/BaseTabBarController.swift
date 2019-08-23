//
//  BaseTabBarController.swift
//  MVI
//
//  Created by Fatih Şen on 18.02.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

open class BaseTabBarController<T: Model, V: ViewModel>: UITabBarController where V.Model == T {
	
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
	
	open func setUp() { /*no opt*/	}
	
	open func attach() {
		// base attach functionality
		viewModel.attach()
		
		// will render view state
		disposeBag += viewModel.store()
			.subscribe(onNext: render(model:))
	}
	
	open func render(model: T) { /*no opt*/	}
	
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
