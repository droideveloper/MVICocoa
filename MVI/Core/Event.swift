//
//  Event.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import Swinject

open class Event {
	
	private static let emptyIntent = EmptyIntent()
	
	public init() { }
	
  open func toIntent(container: Container?) -> Intent {
    return Event.emptyIntent
  }
	
	// default implementation of event payload this will be empty
	open func payload() -> [String: Any] {
		return [:]
	}
}
