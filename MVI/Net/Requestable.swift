//
//  Requestable.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import Alamofire

public protocol Requestable {
  
  var baseUrl: String { get }
	var request: URLRequest { get }
}
