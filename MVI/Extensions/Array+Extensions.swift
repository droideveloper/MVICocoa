//
//  Array+Extensions.swift
//  MVI
//
//  Created by Fatih Şen on 1.06.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation


public extension Array {
	
	func scan<T>(value: T, block: @escaping (Element) -> T) -> T {
		var temp = value
		self.forEach { e in
			temp = block(e)
		}
		return temp
	}
}

