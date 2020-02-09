//
//  ControllerNavigator.swift
//  MVI
//
//  Created by Fatih Şen on 8.02.2020.
//  Copyright © 2020 Fatih Şen. All rights reserved.
//

import Foundation
import UIKit

public protocol ControllerNavigator {
	
	func navigate(_ viewController: UIViewController, _ animated: Bool)
	func navigate(_ viewController: UIViewController, _ transitionStyle: UIModalPresentationStyle)
	func navigate(_ viewController: UIViewController, _ transitionStyle: UIModalPresentationStyle, _ complete: @escaping() -> Void)
}
