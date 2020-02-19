//
//  SyncState.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

public enum SyncState: CustomStringConvertible, Equatable {
	case idle
	case failure(Error)
	case operation(Int, Bool)
	
	public static func ==(lhs: SyncState, rhs: SyncState) -> Bool {
		switch (lhs, rhs) {
			case (.idle, .idle): return true
			case (.failure(let e1), .failure(let e2)): return e1.localizedDescription == e2.localizedDescription
			case (.operation(let t1, _), .operation(let t2, _)): return t1 == t2
			default: return false
		}
	}
	
	public static func ~>(lhs: SyncState, type: Int) -> Bool {
		let eq = operationOf(type)
		return eq == lhs
	}
	
	public static func operationOf(_ type: Int, initial: Bool = false) -> SyncState {
		return .operation(type, initial)
	}
	
	public var description: String {
		get {
			switch self {
				case .idle: return "idle"
				case .failure(let error): return "error: \(error.localizedDescription)"
				case .operation(let type, let state): return "op: \(type) with: \(state)"
			}
		}
	}
		
	// some pre defined content
	public static let refresh = 0x01
	public static let loadMore = 0x02
	
	public static let update = 0x03
	public static let delete = 0x04
	public static let add = 0x05
}



