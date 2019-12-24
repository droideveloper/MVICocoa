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
	
	func onErrorRetry(with max: Int = 3, and delay: Int = 3) -> Observable<Element> {
		return retryWhen { (errors: Observable<Error>) in
			return Observable.zip(errors, Observable<Int>.range(start: 0, count: max)) { _, index in return index }
				.map { t in	return DispatchTimeInterval.seconds(delay * t) }
		}
	}
  
  func applyResource<T>() -> Observable<Resource<T>> where T: Codable, Element == Response<T> {
    return map { response -> Resource<T> in
      if response.code ?? -1 >= 200, response.code ?? -1 <= 299 {
        return .success(response.code, response.data, response.cursor)
      }
      return .failure(response.code, response.message, response.messageFriendly)
    }.onErrorRetry()
  }
}
