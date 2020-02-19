//
//  Observable+Event.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift
import Swinject

public extension Observable where Element == Event {
  
  func toIntent(_ container: Container?) -> Observable<Intent> {
    return self.map { event -> Intent in
      return event.toIntent(container: container)
    }
  }
}
