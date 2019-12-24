//
//  Event.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import Swinject

public let emptyEvent = Event()

open class Event {
	
	private static let emptyIntent = EmptyIntent()
	
	public init() { }
	
  open func toIntent(container: Container?) -> Intent {
    return Event.emptyIntent
  }
}
