//
//  Injectable.swift
//  MVI
//
//  Created by Fatih Şen on 25.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import Swinject

public protocol Injectable {
	
	var container: Container { get }
}
