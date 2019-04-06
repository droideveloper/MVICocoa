//
//  UICollectionView+PropertyChanable.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView: PropertyChangable {
  
  public func notifyItemsChanged(_ index: Int, size: Int) {
    let paths = toIndexPath(index: index, size: size)
    self.reloadItems(at: paths)
  }
  
  public func notifyItemsRemoved(_ index: Int, size: Int) {
    let paths = toIndexPath(index: index, size: size)
    self.deleteItems(at: paths)
  }
  
  public func notifyItemsInserted(_ index: Int, size: Int) {
    let paths = toIndexPath(index: index, size: size)
		if index == 0 {
			self.reloadItems(at: paths)
		} else {
    	self.insertItems(at: paths)
		}
  }
  
  private func toIndexPath(index: Int, size: Int) -> [IndexPath] {
    return (index..<size).map { position in IndexPath(item: position, section: 0) }
  }
}
