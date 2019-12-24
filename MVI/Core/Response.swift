//
//  Response.swift
//  MVI
//
//  Created by Fatih Sen on 24.12.2019.
//  Copyright © 2019 Fatih Şen. All rights reserved.
//

import Foundation

private let encoder = JSONEncoder()

public struct Response<T>: Codable, CustomStringConvertible where T: Codable {
  
  public var code: Int?
  public var message: String?
  public var messageFriendly: String?
  public var data: T?
  public var cursor: String?
    
  public var description: String {
    get {
      do {
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(self)
        return String(data: data, encoding: .utf8) ?? "could not resolve \(Response<T>.self)"
      } catch {
        return error.localizedDescription
      }
    }
  }
  
  public enum CodingKeys: String, CodingKey {
    case code, message, messageFriendly, data, cursor
  }
}
