//
//  Int32+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

extension Int32 {
	
	public func toAlpha() -> Int {
		return Int(self >> 24) & 0xFF
	}
	
	public func toRed() -> Int {
		return Int(self >> 16) & 0xFF
	}
	
	public func toGreen() -> Int {
		return Int(self >> 8) & 0xFF
	}
	
	public func toBlue() -> Int {
		return Int(self) & 0xFF
	}
}
