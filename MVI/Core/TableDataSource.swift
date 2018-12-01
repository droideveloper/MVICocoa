//
//  TableDataSource.swift
//  MVI
//
//  Created by Fatih Şen on 1.12.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit

open class TableDataSource<D: Equatable>: NSObject, UITableViewDataSource {
	
	public var dataSet: ObservableList<D>

	public init(dataSet: ObservableList<D>) {
		self.dataSet = dataSet
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSet.count
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: identifierAt(indexPath), for: indexPath)
		bind(cell, dataSet.get(indexPath.row))
		return cell
	}
	
	open func identifierAt(_ indextPath: IndexPath) -> String {
		return String.empty
	}
	
	open func bind(_ cell: UITableViewCell, _ item: D) {
		// override this
	}
}
