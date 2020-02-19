//
//  ViewFactory.swift
//  MVI
//
//  Created by Fatih Şen on 8.02.2020.
//  Copyright © 2020 Fatih Şen. All rights reserved.
//

import Foundation

public protocol ViewFactory {
	
	func create<T>(_ storyboardName: String, _ type: T.Type) -> T where T: UIViewController
	func create<T>(_ type: T.Type) -> T where T: UIViewController
}
