//
//  HttpMethod.swift
//  MVI
//
//  Created by Fatih Şen on 1.06.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import Alamofire

public enum HttpMethod: CustomStringConvertible {
	case options
	case get
	case head
	case post
	case put
	case patch
	case delete
	case trace
	case connect

	
	public var description: String {
		get {
			switch self {
				case .options: return HTTPMethod.options.rawValue
				case .get: return HTTPMethod.get.rawValue
				case .head: return HTTPMethod.head.rawValue
				case .post: return HTTPMethod.post.rawValue
				case .put: return HTTPMethod.put.rawValue
				case .patch: return HTTPMethod.patch.rawValue
				case .delete: return HTTPMethod.delete.rawValue
				case .trace: return HTTPMethod.trace.rawValue
				case .connect: return HTTPMethod.connect.rawValue
			}
		}
	}
}
