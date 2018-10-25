//
//  Int+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

extension Int {
	
	public func toColorChannel() -> CGFloat {
		return CGFloat(self) / 255.0
	}
	
	public func toAlpha() -> Int {
		return (self >> 24) & 0xFF
	}
	
	public func toRed() -> Int {
		return (self >> 16) & 0xFF
	}
	
	public func toGreen() -> Int {
		return (self >> 8) & 0xFF
	}
	
	public func toBlue() -> Int {
		return self & 0xFF
	}
}
