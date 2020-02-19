//
//  Resource+Sucess.swift
//  MVI
//
//  Created by Fatih Şen on 19.02.2020.
//  Copyright © 2020 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public extension Resource {
	
	func toSuccess<M: Model>(state: Int) -> Observable<Reducer<M>> where M.Entity == T {
		switch self {
		case .success(_, let data, _):
			let lhs: Reducer<M> = { o in o.copy(state: .operation(state, false), data: data ?? M.empty.data) }
			let rhs: Reducer<M> = { o in o.copy(state: .idle, data: M.empty.data) }
			return Observable.of(lhs, rhs)
		case .failure(_, _, let errorString):
			let lhs: Reducer<M> = { o in o.copy(state: .failure(MVIError.of(description: errorString ?? .empty)), data: M.empty.data) }
			let rhs: Reducer<M> = { o in o.copy(state: .idle, data: M.empty.data) }
			return Observable.of(lhs, rhs)
		}
	}
}
