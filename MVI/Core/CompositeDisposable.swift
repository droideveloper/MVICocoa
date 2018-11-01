//
//  CompositeDisposable.swift
//  MVI
//
//  Created by Fatih Şen on 1.11.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public class CompositeDisposable {
	
	private var bag = Array<Disposable>()
	
	public init() { }
	
	public func add(_ disposable: Disposable) {
		bag.append(disposable)
	}
	
	public func clear() {
		bag.forEach { disposable in
			disposable.dispose()
		}
		bag.removeAll()
	}
	
	public static func += (bag: CompositeDisposable, d: Disposable) {
		bag.add(d)
	}
}
