//
//  PropertyChangable.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

public protocol PropertyChangable: class {
  
  func notifyItemsRemoved(_ index: Int, size: Int)
  func notifyItemsInserted(_ index: Int, size: Int)
  func notifyItemsChanged(_ index: Int, size: Int)
}
