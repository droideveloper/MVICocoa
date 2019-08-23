//
//  Interceptor.swift
//  MVI
//
//  Created by Fatih Şen on 2.03.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation

public protocol Interceptor {
	
	func proceed(_ request: URLRequest) -> URLRequest
}
