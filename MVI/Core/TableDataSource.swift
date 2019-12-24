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
  
  private var cacheForSize = Dictionary<String, CGFloat>()
  
	private var emitter: AnyObserver<Bool>? = nil
	private var lastCount: AtomicProperty<Int>
  
  private var selectionEmitter: AnyObserver<Event>? = nil

	public lazy var loadMoreObservable: Observable<Bool> = {
		return Observable.create { emitter in
			self.emitter = emitter
			return Disposables.create()
		}
	}()
  
  // should I call this event so that I can register it into view spec
  public lazy var selectionObservable: Observable<Event> = {
    return Observable<Event>.create { emitter in
      self.selectionEmitter = emitter
      return Disposables.create()
    }
  }()
	
	private let loadMoreDistance: Int
  private let dispatch: (IndexPath, D) -> Event
  
  public init(dataSet: ObservableList<D>, _ loadMoreDistance: Int = 5, _ dispatch: @escaping (IndexPath, D) -> Event = {_, _ in return emptyEvent }) {
		self.dataSet = dataSet
		self.lastCount = AtomicProperty<Int>(defaultValue: dataSet.count)
		self.loadMoreDistance = loadMoreDistance
    self.dispatch = dispatch
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSet.count
	}
  
  public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath:IndexPath) {
    let identifierForPosition = identifierAt(indexPath)
    cacheForSize[identifierForPosition] = cell.frame.size.height
  }
  
  public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    let identifierForPosition = identifierAt(indexPath)
    guard let cacheSize = cacheForSize[identifierForPosition] else {
      return UITableView.automaticDimension
    }
    return cacheSize
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = dataSet.get(indexPath.row)
    selectionEmitter?.onNext(dispatch(indexPath, item))
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
