//
//  CollectionDataSource.swift
//  MVI
//
//  Created by Fatih Şen on 1.12.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

open class CollectionDataSource<D: Equatable>: NSObject, UICollectionViewDataSource {
	
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
		self.lastCount = 0
	}

	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataSet.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierAt(indexPath), for: indexPath)
		bind(cell, dataSet.get(indexPath.item))
		
		if lastCount != dataSet.count {
			let diff = dataSet.count - indexPath.item
			let hasLoadMore = diff <= LOAD_MORE_DISTANCE
			if hasLoadMore {
				lastCount = dataSet.count
				observer?.onNext(hasLoadMore)
			}
		}
		
		return cell
	}
	
	open func identifierAt(_ indexPath: IndexPath) -> String {
		return String.empty
	}
	
	open func bind(_ cell: UICollectionViewCell, _ item: D) {
		// override this
	}
}
