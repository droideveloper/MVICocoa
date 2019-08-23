//
//  Int32+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

extension Int32 {
	
   public var alpha: Int {
    get {
      return Int(self >> 24) & 0xFF
    }
	}
	
  public var red: Int {
    get {
      return Int(self >> 16) & 0xFF
    }
	}
	
  public var green: Int {
    get {
      return Int(self >> 8) & 0xFF
    }
	}
	
  public var blue: Int {
    get {
      return Int(self) & 0xFF
    }
	}
}
