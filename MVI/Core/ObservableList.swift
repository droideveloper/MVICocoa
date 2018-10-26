//
//  ObservableList.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation


public class ObservableList<T> {
  
  private var dataSet = Array<T>()
  private var protocols = Array<PropertyChangable>()
  
  public var count: Int {
    get {
      return dataSet.count
    }
  }
  
  public var isEmpty: Bool {
    get {
      return dataSet.isEmpty
    }
  }
  
  public func register(_ callback: PropertyChangable) {
    let index = protocols.firstIndex(where: { listener in
      return listener === callback
    })
    if index == nil {
      protocols.append(callback)
    }
  }
  
  public func unregister(_ callback: PropertyChangable) {
    let index = protocols.firstIndex(where: { listener in
      return listener === callback
    })
    if let index = index {
      protocols.remove(at: index)
    }
  }
  
  public func append(_ value: T) {
    let index = dataSet.count - 1
		if index >= 0 {
    	dataSet.append(value)
    	notifyInsert(index, size: 1)
		} else {
			dataSet.append(value)
			notifyInsert(0, size: 1)
		}
  }
  
  public func append(_ values: [T]) {
    let index = dataSet.count - 1
		if index >= 0 {
    	dataSet.append(contentsOf: values)
    	notifyInsert(index, size: index + values.count - 1)
		} else {
			dataSet.append(contentsOf: values)
			notifyInsert(0, size: values.count - 1)
		}
  }
  
  public func insert(_ value: T, at: Int) {
		if at >= 0 && at < dataSet.count {
    	dataSet.insert(value, at: at)
    	notifyInsert(at, size: 1)
		}
  }
  
  public func insert(_ values: [T], at: Int) {
		if at >= 0 && at < dataSet.count {
    	dataSet.insert(contentsOf: values, at: at)
    	notifyInsert(at, size: at + values.count - 1)
		}
  }
  
  public func remove(at: Int) {
		if at >= 0 && at < dataSet.count {
    	dataSet.remove(at: at)
    	notifyRemove(at, size: 1)
		}
  }
  
  public func clear() {
    if !dataSet.isEmpty {
      let size = dataSet.count - 1
      dataSet.removeAll()
      notifyRemove(0, size: size)
    }
  }
  
  public func put(at: Int, value: T) {
		if at >= 0 && at < dataSet.count {
    	dataSet[at] = value
    	notifyChange(at, size: 1)
		}
  }
  
  public func get(_ index: Int) -> T {
    return dataSet[index]
  }
  
  private func notifyInsert(_ index: Int, size: Int) {
    protocols.forEach { listener in listener.notifyItemsInserted(index, size: size) }
  }
  
  private func notifyRemove(_ index: Int, size: Int) {
    protocols.forEach { listener in listener.notifyItemsRemoved(index, size: size) }
  }
  
  private func notifyChange(_ index: Int, size: Int) {
    protocols.forEach { listener in listener.notifyItemsChanged(index, size: size) }
  }
}

