//
//  SyncState.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

public protocol SyncState {}

public struct Idle: SyncState, Equatable { }

public struct Process: SyncState, Equatable {
  
  public let type: ProcessType
  
  init(_ type: ProcessType) {
    self.type = type
  }

  public enum ProcessType {
    case refresh, loadMore, create, update, delete, click, longClick, touch, scrollUp, scrollDown
  }
  
  public static func == (lhs: Process, rhs: Process) -> Bool {
    return lhs.type == rhs.type
  }
}

public struct Failure: SyncState, Equatable {
  
  public let error: Error
  
  init(_ error: Error) {
    self.error = error
  }
  
  public static func == (lhs: Failure, rhs: Failure) -> Bool {
    return lhs.error.localizedDescription == rhs.error.localizedDescription
  }
}
