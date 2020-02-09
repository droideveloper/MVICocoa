//
//  URLRequest+Extension.swift
//  MVI
//
//  Created by Fatih Sen on 24.12.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
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
  
  public func execute<T>(_ interceptors: [Interceptor]? = nil) -> Observable<Response<T>> where T: Decodable {
    let request = self.proceed(interceptors)
    return Alamofire.request(request)
      .serialize()
  }
	
	public func execute<T>(_ interceptors: [Interceptor]? = nil, _ block: @escaping (MultipartFormData) -> Void) -> Observable<Response<T>> where T: Decodable {
		let request = self.proceed(interceptors)
		return Observable.create { emitter in
			var disposable: Disposable = Disposables.create()
			
			upload(multipartFormData: block, with: request) { result in
				switch result {
					case .failure(let error):
						emitter.onError(error)
					case .success(let request, _, _):
						let req = request.serialize(completion: { (response: DataResponse<Response<T>>) in
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
