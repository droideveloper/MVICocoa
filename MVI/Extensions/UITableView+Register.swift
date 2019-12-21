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
            
	public func register<A>(_ type: A.Type) where A: UITableViewCell {
		register(type: type)
	}
	
	public func register<A, B>(_ typeA: A.Type, _ typeB: B.Type) where A: UITableViewCell, B: UITableViewCell {
		register(type: typeA)
		register(type: typeB)
	}
	
	public func register<A, B, C>(_ typeA: A.Type, _ typeB: B.Type, _ typeC: C.Type) where A: UITableViewCell, B: UITableViewCell, C: UITableViewCell {
		register(type: typeA)
		register(type: typeB)
		register(type: typeC)
	}
	
	public func register<A, B, C, D>(_ typeA: A.Type, _ typeB: B.Type, _ typeC: C.Type, _ typeD: D.Type) where A: UITableViewCell, B: UITableViewCell, C: UITableViewCell, D: UITableViewCell  {
		register(type: typeA)
		register(type: typeB)
		register(type: typeC)
		register(type: typeD)
	}
	
	public func register<A, B, C, D, E>(_ typeA: A.Type, _ typeB: B.Type, _ typeC: C.Type, _ typeD: D.Type, _ typeE: E.Type) where A: UITableViewCell, B: UITableViewCell, C: UITableViewCell, D: UITableViewCell, E: UITableViewCell  {
		register(type: typeA)
		register(type: typeB)
		register(type: typeC)
		register(type: typeD)
		register(type: typeE)
	}
	
	public func register<A, B, C, D, E, F>(_ typeA: A.Type, _ typeB: B.Type, _ typeC: C.Type, _ typeD: D.Type, _ typeE: E.Type, _ typeF: F.Type) where A: UITableViewCell, B: UITableViewCell, C: UITableViewCell, D: UITableViewCell, E: UITableViewCell, F: UITableViewCell    {
		register(type: typeA)
		register(type: typeB)
		register(type: typeC)
		register(type: typeD)
		register(type: typeE)
		register(type: typeF)
	}
	
	private func register<T>(type: T.Type) where T: UITableViewCell {
		let identifier = String(describing: type)
		register(UINib(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
	}
}
