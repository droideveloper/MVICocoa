//
//  StringModel.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

public struct StringModel: Model {
  public typealias Model = String
  
  public static var empty = StringModel(state: idle, data: String.empty)
  
  public var state: SyncState
  public var data: String
  
  public func copy(state: SyncState? = nil, data: String? = nil) -> StringModel {
    return StringModel(state: state ?? self.state, data: data ?? self.data)
  }
}
