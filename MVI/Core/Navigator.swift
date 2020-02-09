//
//  Navigation.swift
//  MVI
//
//  Created by Fatih Şen on 8.02.2020.
//  Copyright © 2020 Fatih Şen. All rights reserved.
//

import Foundation

public protocol Navigator {
	
	func navigate(_ event: Event)
}
