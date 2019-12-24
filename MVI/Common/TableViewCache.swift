//
//  CollectionTypeCache.swift
//  MVI
//
//  Created by Fatih Sen on 21.12.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation

public protocol TableViewCache {
  func animation(forKey: String) -> UITableView.RowAnimation
  func animation(forKey: String, animation: UITableView.RowAnimation)
  func invalidateAnimations()
  
  func height(forKey: String) -> Float
  func height(forKey: String, height: Float)
  func invalidateHeights()
}
