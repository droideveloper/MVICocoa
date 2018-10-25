//
//  Model.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

public protocol Model {
  associatedtype Entity
  
  static var empty: Self { get }
  
  var state: SyncState { get set }
  var data: Entity { get set }
  
  func copy(state: SyncState?, data: Entity?) -> Self
}
