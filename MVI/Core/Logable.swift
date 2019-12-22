//
//  Logable.swift
//  MVI
//
//  Created by Fatih Şen on 18.11.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation

public enum LogLevel: String {
	case debug = "D"
	case info = "I"
	case warn = "W"
	case error = "E"
}

public protocol Loggable {
	
	var isLogEnabled: Bool { get }
	var classTag: String { get }
	
	func log(_ level: LogLevel, _ message: String, _ fn: String)
	func log(_ message: String, _ fn: String)
	func log(_ error: Error, _ fn: String)
}

private let dateFormatter: DateFormatter = {
	let dateFormat = DateFormatter()
	dateFormat.dateFormat = "dd.mm.yyyy HH:mm:ss"
	return dateFormat
}()

public extension Loggable {
	
	var isLogEnabled: Bool {
		get {
#if DEBUG
			return true
#else
			return false
#endif
		}
	}
	
	var classTag: String {
		get {
			return String(describing: Self.self)
		}
	}
	
	func log(_ level: LogLevel, _ message: String, _ fn: String = #function) {
		if isLogEnabled {
			print("[\(dateFormatter.string(from: Date()))]\t\(level.rawValue)/\(classTag)\t\(fn): \t\(message)")
		}
	}
	
	func log(_ message: String, _ fn: String = #function) {
		log(.debug, message, fn)
	}
	
	func log(_ error: Error, _ fn: String = #function) {
		log(.error, error.localizedDescription, fn)
	}
}
