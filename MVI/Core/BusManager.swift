//
//  BusManager.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public class BusManager {
  
	private static var bus = {
		PublishSubject<Event>()
	}()
	
  public static func send<T>(event: T) where T: Event {
    bus.onNext(event)
  }
  
  public static func register(_ block: @escaping (Event) -> Void) -> Disposable {
    return bus.subscribe(onNext: block)
  }
}
