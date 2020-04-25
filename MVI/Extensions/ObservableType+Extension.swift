//
//  ObservableType+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 25.05.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

public extension ObservableType {
	
	func onErrorRetry(with max: Int = 3, and delay: Int = 3) -> Observable<E> {
		return retryWhen { (errors: Observable<Error>) in
			return Observable.zip(errors, Observable<Int>.range(start: 0, count: max)) { _, index in return index }
				.map { t in	return DispatchTimeInterval.seconds(delay * t) }
		}
	}
}
