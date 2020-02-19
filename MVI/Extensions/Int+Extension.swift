//
//  Int+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

public extension Int {
	
  var colorChannel: CGFloat {
    get {
      return CGFloat(self) / 255.0
    }
	}
	
  var alpha: Int {
    get {
      return (self >> 24) & 0xFF
    }
	}
	
  var red: Int {
    get {
      return (self >> 16) & 0xFF
    }
	}
	
  var green: Int {
    get {
      return (self >> 8) & 0xFF
    }
	}
	
  var blue: Int {
    get {
      return self & 0xFF
    }
	}
}
