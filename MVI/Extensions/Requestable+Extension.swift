//
//  Requestable+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 18.02.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import Alamofire

private let JEncoder = JSONEncoder()

extension Requestable {
	
	public func by<T>(url: URLConvertible, httpMethod: HTTPMethod, body: T, contentType: String = "application/json; charset=UTF-8") -> URLRequest where T: Encodable {
		var request = by(url: url, httpMethod: httpMethod)
		request.addValue(contentType, forHTTPHeaderField: "Content-Type")
		request.httpBody = try? JEncoder.encode(body)
		return request
	}
	
	public func by(url: URLConvertible, httpMethod: HTTPMethod) -> URLRequest {
		return try! URLRequest(url: url, method: httpMethod)
	}
}
