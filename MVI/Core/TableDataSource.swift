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

open class TableDataSource<D: Equatable>: NSObject, UITableViewDataSource {
	
	public var dataSet: ObservableList<D>
	private var emitter: AnyObserver<Bool>? = nil
	private var lastCount: AtomicProperty<Int>

	public lazy var loadMoreObservable: Observable<Bool> = {
		return Observable.create { emitter in
			self.emitter = emitter
			return Disposables.create()
		}
	}()
	
	private let loadMoreDistance: Int
	
	public init(dataSet: ObservableList<D>, _ loadMoreDistance: Int = 5) {
		self.dataSet = dataSet
		self.lastCount = AtomicProperty<Int>(defaultValue: dataSet.count)
		self.loadMoreDistance = loadMoreDistance
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSet.count
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
