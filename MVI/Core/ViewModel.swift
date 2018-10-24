//
//  ViewModel.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public protocol ViewModel {
  associatedtype View
  associatedtype Model
  
  func attach()
  func state() -> Observable<SyncState>
  func store() -> Observable<Model>
  func accept(_ intent: Intent)
}
