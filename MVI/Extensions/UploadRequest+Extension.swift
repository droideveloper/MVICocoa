//
//  UploadRequest+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 9.02.2020.
//  Copyright © 2020 Fatih Şen. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension UploadRequest {
	
	public func uploadMultipart<T>(_ urlRequest: URLRequest, _ block: @escaping (MultipartFormData) -> Void) -> Observable<T> where T: Decodable {
		return Observable.create { emitter in
			
			var disposable: Disposable = Disposables.create()
			
			upload(multipartFormData: block, with: urlRequest) { (result) in
				switch result {
					case .failure(let error):
						emitter.onError(error)
					case .success(_, _, _):
						// serialize coming from DataRequest+Extension
						let request = self.serialize(completion: { (response: DataResponse<T>) in
							switch response.result {
								case .success(let data):
									emitter.onNext(data)
									emitter.onCompleted()
								case .failure(let error):
									emitter.onError(error)
							}
						})
						
						disposable = Disposables.create {
							request.cancel()
						}
				}
			}
			return disposable
		}
	}
}
