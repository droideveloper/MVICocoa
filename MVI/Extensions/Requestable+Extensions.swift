//
//  Requestable+Extensions.swift
//  MVI
//
//  Created by Fatih Şen on 1.06.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import Alamofire

private let JEncoder = JSONEncoder()

public let MEDIA_TYPE_JSON = "application/json; charset=UTF-8"
public let CONTENT_TYPE = "Content-Type"

public extension Requestable {
	
	func create<T>(url: URLConvertible, httpMethod: HTTPMethod, body: T, contentType: String = MEDIA_TYPE_JSON, inteceptors: [Interceptor]? = nil) -> URLRequest where T: Encodable {
		var request = create(url: url, httpMethod: httpMethod)
		request.addValue(contentType, forHTTPHeaderField: CONTENT_TYPE)
		if let interceptors = inteceptors {
			request = interceptors.scan(value: request) { interceptor in
				return interceptor.proceed(request)
			}
		}
		request.httpBody = try? JEncoder.encode(body)
		return request
	}
	
	func create<T>(url: URLConvertible, httpMethod: HTTPMethod, body: T, contentType: String = MEDIA_TYPE_JSON, interceptor: Interceptor? = nil) -> URLRequest where T: Encodable {
		var request = create(url: url, httpMethod: httpMethod)
		request.addValue(contentType, forHTTPHeaderField: CONTENT_TYPE)
		if let interceptor = interceptor {
			request = interceptor.proceed(request)
		}
		request.httpBody = try? JEncoder.encode(body)
		return request
	}
	
	func create(url: URLConvertible, httpMethod: HTTPMethod) -> URLRequest {
		return try! URLRequest(url: url, method: httpMethod)
	}
	
	func create(url: URLConvertible, httpMethod: HTTPMethod, interceptors: [Interceptor]? = nil) -> URLRequest {
		var request = try! URLRequest(url: url, method: httpMethod)
		if let interceptors = interceptors {
			request = interceptors.scan(value: request) { interceptor in
				return interceptor.proceed(request)
			}
		}
		return request
	}
	
	func create(url: URLConvertible, httpMethod: HTTPMethod, interceptor: Interceptor? = nil) -> URLRequest {
		var request = try! URLRequest(url: url, method: httpMethod)
		if let interceptor = interceptor {
			request = interceptor.proceed(request)
		}
		return request
	}
}
