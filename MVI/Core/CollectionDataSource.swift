//
//  CollectionDataSource.swift
//  MVI
//
//  Created by Fatih Şen on 1.12.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit

open class CollectionDataSource<D: Equatable>: NSObject, UICollectionViewDataSource {
	
	public var dataSet: ObservableList<D>
	
	public init(dataSet: ObservableList<D>) {
		self.dataSet = dataSet
	}

	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataSet.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identfierAt(indexPath), for: indexPath)
		bind(cell, dataSet.get(indexPath.item))
		return cell
	}
	
	open func identfierAt(_ indexPath: IndexPath) -> String {
		return String.empty
	}
	
	open func bind(_ cell: UICollectionViewCell, _ item: D) {
		// override this
	}
	
}
