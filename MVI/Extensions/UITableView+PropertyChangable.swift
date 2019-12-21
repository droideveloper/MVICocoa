//
//  UITableView+PropertyChanable.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit

extension UITableView: PropertyChangable {
  
  public func notifyItemsChanged(_ index: Int, size: Int, forKey: String) {
    let paths = toIndexPath(index: index, size: size)
    
    let cache = TableViewCacheImp.shared
    let animation = cache.animation(forKey: forKey)
    self.reloadRows(at: paths, with: animation)
  }
  
  public func notifyItemsRemoved(_ index: Int, size: Int, forKey: String) {
    let paths = toIndexPath(index: index, size: size)
    
    let cache = TableViewCacheImp.shared
    let animation = cache.animation(forKey: forKey)
    self.deleteRows(at: paths, with: animation)
  }
  
  public func notifyItemsInserted(_ index: Int, size: Int, forKey: String) {
    let paths = toIndexPath(index: index, size: size)
    
    let cache = TableViewCacheImp.shared
    let animation = cache.animation(forKey: forKey)
    self.insertRows(at: paths, with: animation)
  }
  
  private func toIndexPath(index: Int, size: Int) -> [IndexPath] {
    return (index..<size).map { position in IndexPath(row: position, section: 0) }
  }
}
