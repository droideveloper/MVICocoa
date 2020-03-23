//
//  MVIError.swift
//  MVI
//
//  Created by Fatih Şen on 3.06.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation

public struct MVIError: Error, CustomStringConvertible {
	
	public let localizedDescription: String
	public let code: Int

	public static func of(description string: String, with code: Int = -1) -> MVIError {
		return MVIError(localizedDescription: string, code: code)
	}
	
	public var description: String {
		get {
			return "code: \(code) description: \(localizedDescription)"
		}
	}
}
