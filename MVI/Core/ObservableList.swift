//
//  ObservableList.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation


public class ObservableList<T> where T: Equatable {
  
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
  
  private let forKey: String
	
  public init(_ forKey: String) {
    self.forKey = forKey
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
		if dataSet.count - 1 >= 0 {
    	dataSet.append(value)
			let index = dataSet.count - 1
    	notifyInsert(index, size: dataSet.count)
		} else {
			dataSet.append(value)
			notifyInsert(0, size: 1)
		}
  }
  
  public func append(_ values: [T]) {
		if dataSet.count - 1 >= 0 {
    	dataSet.append(contentsOf: values)
			let index = dataSet.count - values.count
    	notifyInsert(index, size: dataSet.count)
		} else {
			dataSet.append(contentsOf: values)
			notifyInsert(0, size: values.count)
		}
  }
  
  public func insert(_ value: T, at: Int) {
		if at >= 0 && at < dataSet.count {
    	dataSet.insert(value, at: at)
    	notifyInsert(at, size: at + 1)
		}
  }
  
  public func insert(_ values: [T], at: Int) {
		if at >= 0 && at < dataSet.count {
    	dataSet.insert(contentsOf: values, at: at)
    	notifyInsert(at, size: at + values.count)
		}
  }
  
  public func remove(at: Int) {
		if at >= 0 && at < dataSet.count {
    	dataSet.remove(at: at)
    	notifyRemove(at, size: at + 1)
		}
  }
  
  public func clear() {
    if !dataSet.isEmpty {
      let size = dataSet.count
      dataSet.removeAll()
      notifyRemove(0, size: size)
    }
  }
  
  public func put(at: Int, value: T) {
		if at >= 0 && at < dataSet.count {
    	dataSet[at] = value
    	notifyChange(at, size: at + 1)
		}
  }
  
  public func get(_ index: Int) -> T {
    return dataSet[index]
  }
	
	public func asArray() -> Array<T> {
		return dataSet
	}
	
	public func indexOf(_ value: T) -> Int {
		return dataSet.index(of: value) ?? -1
	}
  
  private func notifyInsert(_ index: Int, size: Int) {
    protocols.forEach { listener in listener.notifyItemsInserted(index, size: size, forKey: forKey) }
  }
  
  private func notifyRemove(_ index: Int, size: Int) {
    protocols.forEach { listener in listener.notifyItemsRemoved(index, size: size, forKey: forKey) }
  }
  
  private func notifyChange(_ index: Int, size: Int) {
    protocols.forEach { listener in listener.notifyItemsChanged(index, size: size, forKey: forKey) }
  }
}

