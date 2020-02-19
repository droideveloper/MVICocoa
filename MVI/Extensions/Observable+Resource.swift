//
//  Observable+toResource.swift
//  MVI
//
//  Created by Fatih Şen on 19.02.2020.
//  Copyright © 2020 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public extension Observable {
	
	func toResource<T>() -> Observable<Resource<T>> where Element == Response<T> {
		return map { response in
			let code = response.code ?? 500
			if code >= 200 && code <= 299 {
				return .success(code, response.data, response.cursor)
			}
			return .failure(code, response.message, response.messageFriendly)
		}
	}
}
