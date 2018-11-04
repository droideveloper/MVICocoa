//
//  FileRepositoryImp.swift
//  MVI
//
//  Created by Fatih Şen on 4.11.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public class FileRepositoryImp: FileRepository {
	
	private let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
	
	public var directory: URL {
		get {
			if let dir = dir {
				return dir
			}
			fatalError("we can not access documents directory for this user")
		}
	}
	
	public init() {}
	
	public func read<T>(url: URL, as type: T.Type) -> Observable<T> where T: Codable {
		return Observable.create { emitter in
			do {
				let decoder = JSONDecoder()
				let fileManager = FileManager.default
				
				if fileManager.fileExists(atPath: url.path) {
					if let data = fileManager.contents(atPath: url.path) {
						let result = try decoder.decode(type, from: data)
						emitter.onNext(result)
						emitter.onCompleted()
					}
				} else {
					let error = NSError(domain: "you can not read this file since no such file \(url.path) exists", code: 400, userInfo: nil)
					emitter.onError(error)
				}
			} catch {
				emitter.onError(error)
			}
			
			return Disposables.create()
		}
	}
	
	public func write<T>(url: URL, object: T) -> Completable where T: Codable {
		return Completable.create { emitter in
			do {
				let encoder = JSONEncoder()
				let fileManager = FileManager.default
				
				let data = try encoder.encode(object)
				if fileManager.fileExists(atPath: url.path) {
					try fileManager.removeItem(at: url)
				}
				let success = fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
				if success {
					emitter(.completed)
				} else {
					let error = NSError(domain: "you could not create file at \(url.path)", code: 400, userInfo: nil)
					emitter(.error(error))
				}
			} catch {
				emitter(.error(error))
			}
			return Disposables.create()
		}
	}
}
