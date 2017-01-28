//
//  JSONEncoderDecoder.swift
//  SWAPI
//
//  Created by Blake Merryman on 1/28/17.
//  Copyright © 2017 Blake Merryman. All rights reserved.
//

import Foundation

// MARK: - JSON Helpers

public protocol JSONEncoderDecoder {
  func encodeJSON(fromDictionary dictionary: [String:AnyObject]?) -> Data?
  func decodeJSON(fromData data: Data?) -> [String:AnyObject]?
}

public extension JSONEncoderDecoder {

  func encodeJSON(fromDictionary dictionary: [String:AnyObject]?) -> Data? {

    guard let dictionary = dictionary else {
      return nil
    }

    do {
      let encoded = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
      return encoded
    } catch let error {
      debugPrint("ERROR ENCODING JSON --- \(error.localizedDescription)")
      return nil
    }
  }

  func decodeJSON(fromData data: Data?) -> [String:AnyObject]? {

    guard let data = data else {
      return nil
    }

    do {
      let decoded = try JSONSerialization.jsonObject(with: data, options: [])
      return decoded as? [String:AnyObject]
    } catch let error {
      debugPrint("ERROR DECODING DATA --- \(error.localizedDescription)")
      return nil
    }
  }
  
}

/// JSON encoder/decoder helper structure.
public struct JSONHelper: JSONEncoderDecoder {
  public static let shared = JSONHelper()
  private init() {}
}
