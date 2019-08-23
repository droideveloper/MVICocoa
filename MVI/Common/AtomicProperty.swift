//
//  AtomicProperty.swift
//  MVI
//
//  Created by Fatih Şen on 23.08.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation

public class AtomicProperty<T> {
	
	private var obj = SpinLock()
	private var _value: T
	
	public var value: T {
		get {
			obj.hold()
			let property = self._value
			obj.release()
			return property
		}
		
		set {
			obj.hold()
			self._value = newValue
			obj.release()
		}
	}
	
	
	public init(defaultValue: T) {
		self._value = defaultValue
	}
}
