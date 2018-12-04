//
//  UITableView+Register.swift
//  MVI
//
//  Created by Fatih Şen on 4.12.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
	
	public func register<T>(types: T.Type...) where T: UITableViewCell {
		register(types: types)
	}
	
	private func register<T>(types: [T.Type]) where T: UITableViewCell {
		types.forEach { type in
			let identifier = String(describing: type)
			register(UINib(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
		}
	}
}
