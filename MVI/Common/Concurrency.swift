//
//  Concurrency.swift
//  MVI
//
//  Created by Fatih Şen on 24.08.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public protocol Concurrency {
	
	var dispatchScheduler: SchedulerType { get }
}
