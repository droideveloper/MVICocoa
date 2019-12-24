//
//  Requestable+Extensions.swift
//  MVI
//
//  Created by Fatih Şen on 1.06.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import Alamofire

public let MEDIA_TYPE_JSON = "application/json; charset=UTF-8"
public let CONTENT_TYPE = "Content-Type"

public extension Requestable {
  
  func create<T>(url: URLConvertible, httpMethod: HTTPMethod, body: T, contentType: String = MEDIA_TYPE_JSON, encoder: JSONEncoder = JSONEncoder()) -> URLRequest where T: Encodable {
		var request = create(url: url, httpMethod: httpMethod)
		request.addValue(contentType, forHTTPHeaderField: CONTENT_TYPE)
		request.httpBody = try? encoder.encode(body)
		return request
	}
	
	func create(url: URLConvertible, httpMethod: HTTPMethod) -> URLRequest {
		return try! URLRequest(url: url, method: httpMethod)
	}
}
