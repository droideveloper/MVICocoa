//
//  ControllerNavigatorImp.swift
//  MVI
//
//  Created by Fatih Şen on 8.02.2020.
//  Copyright © 2020 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit

public class ControllerNavigatorImp: ControllerNavigator {
	
	private weak var delegate: UIViewController? = nil
	
	public init(delegate: UIViewController?) {
		self.delegate = delegate
	}
	
	public func navigate(_ viewController: UIViewController, _ animated: Bool) {
		guard let delegate = delegate?.navigationController else {
			fatalError("controller is not bound by UINavigationController")
		}
		delegate.pushViewController(viewController, animated: animated)
	}
	
	public func navigate(_ viewController: UIViewController, _ transitionStyle: UIModalPresentationStyle) {
		navigate(viewController, transitionStyle) {
			/*
				no-opt block that we push it just in case others want to use this
			*/
		}
	}
	
	public func navigate(_ viewController: UIViewController, _ transitionStyle: UIModalPresentationStyle, _ complete: @escaping () -> Void) {
		switch delegate {
			case is UINavigationController:
				guard let delegate = delegate as? UINavigationController else {
					fatalError("controller is not bound by UINavigationController")
				}
				transitionInternal(delegate, viewController, transitionStyle, complete)
				break
			default:
				guard let delegate = delegate?.navigationController else {
					fatalError("controller is not bound by UINavigationController")
				}
				transitionInternal(delegate, viewController, transitionStyle, complete)
				break
		}
	}
	
	internal func transitionInternal(_ parent: UINavigationController, _ viewController: UIViewController, _ transitionStyle: UIModalPresentationStyle, _ complete: (() -> Void)? = nil) {
		viewController.modalPresentationStyle = transitionStyle
		parent.present(viewController, animated: true, completion: complete)
	}
}
