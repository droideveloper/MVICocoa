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
	private var observer: AnyObserver<Bool>? = nil
	private var lastCount: Int
	
	public lazy var loadMoreObservable: Observable<Bool> = {
		return Observable.create { observer in
			self.observer = observer
			return Disposables.create()
		}
	}()
	
	private let LOAD_MORE_DISTANCE = 5
	
	public init(dataSet: ObservableList<D>) {
		self.dataSet = dataSet
		self.lastCount = dataSet.count
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSet.count
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: identifierAt(indexPath), for: indexPath)
		bind(cell, dataSet.get(indexPath.row))
		
		if lastCount != dataSet.count {
			let diff = dataSet.count - indexPath.row
			let hasLoadMore = diff <= LOAD_MORE_DISTANCE
			if hasLoadMore {
				lastCount = dataSet.count
				observer?.onNext(hasLoadMore)
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
