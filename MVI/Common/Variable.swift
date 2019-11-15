//
//  Variable.swift
//  MVI
//
//  Created by Fatih Şen on 15.11.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

public final class Variable<T> where T: Equatable {
	
	// internal storage for new object called variable
	private let _subject: BehaviorRelay<T>
	
	// state
	private var _value: T
	
	/// Gets or sets current value of variable.
	///
	/// Whenever a new value is set, all the observers are notified of the change.
	///
	public var value: T {
		get {
			return self._value
		}
		set(newValue) {
			if self._value != newValue {
				self._value = newValue
				self._subject.accept(newValue)
			}
		}
	}
	
	/// Initializes variable with initial value.
	///
	/// - parameter value: Initial variable value.
	public init(_ value: T) {
		self._value = value
		self._subject = BehaviorRelay(value: value)
	}
	
	/// - returns: Canonical interface for push style sequence
	public func asObservable() -> Observable<T> {
		return self._subject.asObservable()
	}
}
