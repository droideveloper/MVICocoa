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

public struct Operation: SyncState, Equatable {
  
  public let type: Int
  
  public init(_ type: Int) {
    self.type = type
  }
  
  public static func == (lhs: Operation, rhs: Operation) -> Bool {
    return lhs.type == rhs.type
  }
}

public struct Failure: SyncState, Equatable {
  
  public let error: Error
  
  public init(_ error: Error) {
    self.error = error
  }
  
  public static func == (lhs: Failure, rhs: Failure) -> Bool {
    return lhs.error.localizedDescription == rhs.error.localizedDescription
  }
}

public let idle = Idle()
//
private let refreshOperation = 0x01
public let refresh = Operation(refreshOperation)

