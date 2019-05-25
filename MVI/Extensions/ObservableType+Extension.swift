//
//  ObservableType+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 25.05.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {
	
	func onErrorRetry(with max: Int = 3, and delay: Double = 3) -> Observable<Element> {
		return retryWhen { (errors: Observable<Error>) in
			return Observable.zip(errors, Observable<Int>.range(start: 0, count: max)) { _, index in return index }
				.flatMap { t in	return Observable<Int>.timer(delay, scheduler: ConcurrentMainScheduler.instance) }
		}
	}
}
