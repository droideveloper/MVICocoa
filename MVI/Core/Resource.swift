//
//  Resource.swift
//  MVI
//
//  Created by Fatih Şen on 3.06.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation

public enum Resource<T>: CustomStringConvertible {
	case success(Int?, T?, String?)
	case failure(Int?, String?, String?)
	
	public var description: String {
		get {
			switch self {
				case .success(let code, let data, _):
					guard let data = data else {
						return "code: \(code ?? -1)"
					}
					return "code: \(code ?? -1) data: \(data)"
				case .failure(let code, _, let messageFriendly):
					guard let messageFriendly = messageFriendly else {
						return "code: \(code ?? -1)"
					}
					return "code: \(code ?? -1) messageFriendly: \(messageFriendly)"
			}
		}
	}
}
