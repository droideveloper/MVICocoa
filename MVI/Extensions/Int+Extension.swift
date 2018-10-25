//
//  Int+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

extension Int {
	
  public var colorChannel: CGFloat {
    get {
      return CGFloat(self) / 255.0
    }
	}
	
  public var alpha: Int {
    get {
      return (self >> 24) & 0xFF
    }
	}
	
  public var red: Int {
    get {
      return (self >> 16) & 0xFF
    }
	}
	
  public var green: Int {
    get {
      return (self >> 8) & 0xFF
    }
	}
	
  public var blue: Int {
    get {
      return self & 0xFF
    }
	}
}
