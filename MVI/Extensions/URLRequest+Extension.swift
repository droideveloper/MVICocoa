//
//  URLRequest+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 14.02.2020.
//  Copyright © 2020 Fatih Şen. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

extension URLRequest {
  
  public func proceed(_ interceptors: [Interceptor]? = nil) -> URLRequest {
    return interceptors?.scan(value: self) { interceptor in
      return interceptor.proceed(self)
    } ?? self
  }
  
  public func execute<T>(_ interceptors: [Interceptor]? = nil) -> Observable<T> where T: Decodable {
    let request = self.proceed(interceptors)
		
    return Alamofire.request(request)
      .serialize()
  }
	
	public func execute<T>(_ interceptors: [Interceptor]? = nil, _ block: @escaping (MultipartFormData) -> Void) -> Observable<T> where T: Decodable {
		let request = self.proceed(interceptors)
		
		return Observable.create { emitter in
			var disposable: Disposable = Disposables.create()
			
			upload(multipartFormData: block, with: request) { result in
				switch result {
					case .failure(let error):
						emitter.onError(error)
					case .success(let request, _, _):
						let req = request.serialize(completion: { (response: DataResponse<T>) in
							switch response.result {
								case .success(let data):
									emitter.onNext(data)
									emitter.onCompleted()
								case .failure(let error):
									emitter.onError(error)
							}
						})
					
						disposable = Disposables.create {
							req.cancel()
						}
				}
			}
			
			return disposable
		}
	}
}
