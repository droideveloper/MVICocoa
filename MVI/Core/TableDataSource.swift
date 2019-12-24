//
//  TableDataSource.swift
//  MVI
//
//  Created by Fatih Şen on 1.12.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

open class TableDataSource<D: Equatable>: NSObject, UITableViewDataSource, UITableViewDelegate {
	
	public var dataSet: ObservableList<D>
  
  private lazy var cacheManager: TableViewCache = {
    TableViewCacheImp.shared
  }()
  
	private var emitter: AnyObserver<Bool>? = nil
	private var lastCount: AtomicProperty<Int>
  
  private var selectionEmitter: AnyObserver<D>? = nil

	public lazy var loadMoreObservable: Observable<Bool> = {
		return Observable.create { emitter in
			self.emitter = emitter
			return Disposables.create()
		}
	}()
  
  public lazy var selectionObservable: Observable<D> = {
    return Observable<D>.create { emitter in
      self.selectionEmitter = emitter
      return Disposables.create()
    }
  }()
	
	private let loadMoreDistance: Int
  
  public init(dataSet: ObservableList<D>, _ loadMoreDistance: Int = 5) {
		self.dataSet = dataSet
		self.lastCount = AtomicProperty<Int>(defaultValue: dataSet.count)
		self.loadMoreDistance = loadMoreDistance
    super.init()
    self.cacheManager.invalidateHeights() // we need to invalidate cache for this key
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSet.count
	}
  
  public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath:IndexPath) {
    let identifierForPosition = identifierAt(indexPath)
    if (cacheManager.height(forKey: identifierForPosition) != CGFloat.nan) {
      cacheManager.height(forKey: identifierForPosition, height: cell.frame.size.height)
    }
  }
  
  public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    let identifierForPosition = identifierAt(indexPath)
    if cacheManager.height(forKey: identifierForPosition) != CGFloat.nan {
      let expectedSize = cacheManager.height(forKey: identifierForPosition)
      if expectedSize != CGFloat.nan {
        return expectedSize
      }
      return UITableView.automaticDimension
    }
    return UITableView.automaticDimension
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = dataSet.get(indexPath.row)
    selectionEmitter?.onNext(item)
  }
  
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: identifierAt(indexPath), for: indexPath)
		bind(cell, dataSet.get(indexPath.row))
		
		let lastCount = self.lastCount.value
		if lastCount != dataSet.count {
			let diff = dataSet.count - indexPath.row
			let hasLoadMore = diff <= loadMoreDistance
			if hasLoadMore {
				self.lastCount.value = dataSet.count
				emitter?.onNext(hasLoadMore)
			}
		}
		
		return cell
	}
	
	open func identifierAt(_ indextPath: IndexPath) -> String {
		return String.empty
	}
	
	open func bind(_ cell: UITableViewCell, _ item: D) {
		// override this
	}
}
