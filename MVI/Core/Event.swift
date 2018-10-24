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
  
  private let emptyIntent = EmptyIntent()
  
  open func toIntent(container: Container?) -> Intent {
    return emptyIntent
  }
}
