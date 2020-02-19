//
//  ViewFactoryImp.swift
//  MVI
//
//  Created by Fatih Şen on 8.02.2020.
//  Copyright © 2020 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit

public class ViewFactoryImp: ViewFactory {
	
	private weak var delegate: UIViewController? = nil
	
	public init(delegate: UIViewController?) {
		self.delegate = delegate
	}
	
	public func create<T>(_ storyboardName: String, _ type: T.Type) -> T where T: UIViewController {
		guard let delegate = delegate else {
			fatalError("delegate is not bound")
		}
		return delegate.instantiateFromStoryboardHelper(storyboardName, type: type)
	}
	
	public func create<T>(_ type: T.Type) -> T where T: UIViewController {
		return create("Main", type)
	}
}
