//
//  TableViewCacheImp.swift
//  MVI
//
//  Created by Fatih Sen on 21.12.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit

public class TableViewCacheImp: TableViewCache {
   
  public static let shared: TableViewCache = TableViewCacheImp()
  
  private var animationCache: [String: UITableView.RowAnimation] = Dictionary()
  private var heightCache: [String: Float] = Dictionary()
  
  private init() {}
  
  public func animation(forKey: String) -> UITableView.RowAnimation {
    guard let item = animationCache[forKey] else {
      return .automatic
    }
    return item
  }
  
  public func animation(forKey: String, animation: UITableView.RowAnimation) {
    animationCache[forKey] = animation
  }
  
  public func invalidateAnimations() {
    animationCache.removeAll()
  }
  
  public func height(forKey: String) -> Float {
    guard let item = heightCache[forKey] else {
      return Float.nan
    }
    return item
  }
  
  public func height(forKey: String, height: Float) {
    heightCache[forKey] = height
  }
  
  public func invalidateHeights() {
    heightCache.removeAll()
  }
}
