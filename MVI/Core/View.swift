//
//  View.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift
import Swinject

public protocol View {
  associatedtype ViewModel
  associatedtype Model
  
  var container: Container? { get }
  
  func setUp()
  func attach()
  func render(model: Model)
  func viewEvents() -> Observable<Event>
}
