//
//  Requestable+Extensions.swift
//  MVI
//
//  Created by Fatih Şen on 1.06.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation

public extension Requestable {
	
	internal func createRequest<T>(from urlString: String, method: HttpMethod = .get, payload: T? = nil, serializer: JSONEncoder = JSONEncoder()) -> URLRequest where T: Encodable {
		guard let url = URL(string: urlString) else {
			fatalError("\(urlString) is not valid")
		}
		var request = URLRequest(url: url)
		request.httpMethod = method.description
		if let payload = payload {
			do {
				request.httpBody = try serializer.encode(payload)
			} catch {
				#if DEBUG
					fatalError("serialization error \(error.localizedDescription)")
				#endif
			}
		}
		return request
	}
	
	func request<T>(from urlString: String, method: HttpMethod = .get, interceptors: [Interceptor]? = nil, payload: T? = nil, serializer: JSONEncoder = JSONEncoder()) -> URLRequest where T: Encodable {
		var request = createRequest(from: urlString, method: method, payload: payload, serializer: serializer)
		if let interceptors = interceptors {
			request = interceptors.scan(value: request) { interceptor in
				return interceptor.intercept(request)
			}
		}
		return request
	}
}
