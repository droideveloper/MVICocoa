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
	private let fileManager = FileManager.default
	private let decoder = JSONDecoder()
	private let encoder = JSONEncoder()
	
	public init() {}
	
	public func file(for path: String) -> URL? {
		return dir?.appendingPathComponent(path)
	}
	
	public func read<T>(url: URL, as type: T.Type) -> Observable<T> where T: Codable {
		return Observable.create { emitter in
			do {
				if self.fileManager.fileExists(atPath: url.path) {
					if let data = self.fileManager.contents(atPath: url.path) {
						let result = try self.decoder.decode(type, from: data)
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
				
				let data = try self.encoder.encode(object)
				if self.fileManager.fileExists(atPath: url.path) {
					try self.fileManager.removeItem(at: url)
				}
				let success = self.fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
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
