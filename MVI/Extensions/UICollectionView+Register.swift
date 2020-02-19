//
//  UICollectionView+Register.swift
//  MVI
//
//  Created by Fatih Şen on 4.12.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView {
	
	func register<A>(_ type: A.Type) where A: UICollectionViewCell {
		register(type: type)
	}
	
	func register<A, B>(_ typeA: A.Type, _ typeB: B.Type) where A: UICollectionViewCell, B: UICollectionViewCell {
		register(type: typeA)
		register(type: typeB)
	}
	
	func register<A, B, C>(_ typeA: A.Type, _ typeB: B.Type, _ typeC: C.Type) where A: UICollectionViewCell, B: UICollectionViewCell, C: UICollectionViewCell {
		register(type: typeA)
		register(type: typeB)
		register(type: typeC)
	}
	
	func register<A, B, C, D>(_ typeA: A.Type, _ typeB: B.Type, _ typeC: C.Type, _ typeD: D.Type) where A: UICollectionViewCell, B: UICollectionViewCell, C: UICollectionViewCell, D: UICollectionViewCell  {
		register(type: typeA)
		register(type: typeB)
		register(type: typeC)
		register(type: typeD)
	}
	
	func register<A, B, C, D, E>(_ typeA: A.Type, _ typeB: B.Type, _ typeC: C.Type, _ typeD: D.Type, _ typeE: E.Type) where A: UICollectionViewCell, B: UICollectionViewCell, C: UICollectionViewCell, D: UICollectionViewCell, E: UICollectionViewCell  {
		register(type: typeA)
		register(type: typeB)
		register(type: typeC)
		register(type: typeD)
		register(type: typeE)
	}
	
	func register<A, B, C, D, E, F>(_ typeA: A.Type, _ typeB: B.Type, _ typeC: C.Type, _ typeD: D.Type, _ typeE: E.Type, _ typeF: F.Type) where A: UICollectionViewCell, B: UICollectionViewCell, C: UICollectionViewCell, D: UICollectionViewCell, E: UICollectionViewCell, F: UICollectionViewCell    {
		register(type: typeA)
		register(type: typeB)
		register(type: typeC)
		register(type: typeD)
		register(type: typeE)
		register(type: typeF)
	}
	
	private func register<T>(type: T.Type) where T: UICollectionViewCell {
		let identifier = String(describing: type)
		register(UINib(nibName: identifier, bundle: Bundle.main), forCellWithReuseIdentifier: identifier)
	}
}
