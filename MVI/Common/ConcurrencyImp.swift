//
//  ConcurrencyImp.swift
//  MVI
//
//  Created by Fatih Şen on 24.08.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import Foundation
import RxSwift

public class ConcurrencyImp: Concurrency {
	
	public static let shared: Concurrency = ConcurrencyImp()
	
  public var dispatcher: SchedulerType {
    get {
      return self._dispatcher
    }
  }
  
	public var dispatchScheduler: SchedulerType {
		get {
      return MainScheduler.asyncInstance
		}
	}
	
  private let _dispatcher: SchedulerType
  
	private init() {
    self._dispatcher = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
  }
}
