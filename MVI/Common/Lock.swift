//
//  Lock.swift
//  MVI
//
//  Created by Fatih Şen on 23.08.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation

public protocol Lock {
	func hold()
	func release()
}
