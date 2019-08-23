//
//  SpinLock.swift
//  MVI
//
//  Created by Fatih Şen on 23.08.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation

public class SpinLock: Lock {
	
	private var obj = os_unfair_lock_s()
	
	public func hold() {
		os_unfair_lock_lock(&obj)
	}
	
	public func release() {
		os_unfair_lock_unlock(&obj)
	}
}
