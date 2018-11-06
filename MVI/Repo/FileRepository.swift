//
//  FileRepository.swift
//  MVI
//
//  Created by Fatih Şen on 4.11.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public protocol FileRepository {
	
	func file(for path: String) -> URL?
	func write<T: Codable>(url: URL, object: T) -> Completable
	func read<T: Codable>(url: URL, as type: T.Type) -> Observable<T>
}
