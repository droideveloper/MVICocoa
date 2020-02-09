//
//  DataRequest+Extension.swift
//  MVI
//
//  Created by Fatih Şen on 24.10.2018.
//  Copyright © 2018 Fatih Şen. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension DataRequest {
  
  private static func serialize<T: Decodable>(decoder: JSONDecoder) -> DataResponseSerializer<T> {
    return DataResponseSerializer { _, response, data, error in
      if let error = error {
        return .failure(error)
      }
      return decode(decoder: decoder, response: response, data: data)
    }
  }
  
  private static func decode<T: Decodable>(decoder: JSONDecoder, response: HTTPURLResponse?, data: Data?) -> Result<T> {
    let result = Request.serializeResponseData(response: response, data: data, error: nil)
    switch result {
      case .success(let data):
        do {
          let entity = try decoder.decode(T.self, from: data)
          return .success(entity)
        } catch {
          return .failure(error)
        }
      case .failure(let error):
        return .failure(error)
    }
  }
  
  @discardableResult
  public func serialize<T: Decodable>(decoder: JSONDecoder = JSONDecoder(), completion: @escaping (DataResponse<T>) -> Void) -> Self {
    return response(queue: nil, responseSerializer: DataRequest.serialize(decoder: decoder), completionHandler: completion)
  }
  
  public func serialize<T: Decodable>() -> Observable<T> {
    return Observable.create { emitter in
      let request = self.serialize(completion: { (response: DataResponse<T>) in
        switch response.result {
          case .success(let data):
            emitter.onNext(data)
            emitter.onCompleted()
          case .failure(let error):
            emitter.onError(error)
        }
      })
      return Disposables.create {
        request.cancel()
      }
    }
  }
	
	// have to be in data request because of reasons unknown
	public func uploadMultipart<T>(_ block: @escaping (MultipartFormData) -> Void) -> Observable<T> where T: Decodable {
		return Observable.create { emitter in
			
			var disposable: Disposable = Disposables.create()
			
			guard let urlRequest = self.request else {
				emitter.onError(MVIError(localizedDescription: "can not locale request", code: -1))
				return disposable
			}
			
			upload(multipartFormData: block, with: urlRequest) { (result) in
				switch result {
					case .failure(let error):
						emitter.onError(error)
					case .success(_, _, _):

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
