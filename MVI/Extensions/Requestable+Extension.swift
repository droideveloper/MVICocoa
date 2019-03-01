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
	
	public func create<T>(url: URLConvertible, httpMethod: HTTPMethod, body: T, contentType: String = MEDIA_TYPE_JSON, interceptor: Interceptor? = nil) -> URLRequest where T: Encodable {
		var request = create(url: url, httpMethod: httpMethod)
		request.addValue(contentType, forHTTPHeaderField: CONTENT_TYPE)
		if let interceptor = interceptor {
			request = interceptor.intercept(request)
		}
		request.httpBody = try? JEncoder.encode(body)
		return request
	}
	
	public func create(url: URLConvertible, httpMethod: HTTPMethod) -> URLRequest {
		return try! URLRequest(url: url, method: httpMethod)
	}
}

public let MEDIA_TYPE_JSON = "application/json; charset=UTF-8"
public let CONTENT_TYPE = "Content-Type"
