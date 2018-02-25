//
//  SWDataController.swift
//  SWAPI
//
//  Created by Blake Merryman on 1/28/17.
//  Copyright © 2017 Blake Merryman. All rights reserved.
//

import Foundation
import CoreData

/*:
 # A Simple Data Controller

 - Our model conforms to `NSCoding` but can't actually persist itself.

 - DataController handles reading-data-from and writing-data-to disk.

 - Wrapping `Encodable`/`Decodable` allows us to simplify the interface while ensuring proper model typing.

 */
class SWDataController {

  private static let coreDataController = CoreDataController(modelName: "Model")

  /*: Attempts to a create a character object. */
  class func createCharacter(from data: Data) -> SWCharacter? {

    return try? JSONDecoder.shared.decode(SWCharacter.self, from: data)

  }

  /*: Attempts to save a character object to disk. */
  class func save(character: SWCharacter) -> Bool {

    return coreDataController.save(character)

  }

  /*: Attempts to load a character using it's name (i.e. used as filename). */
  class func load(characterNamed: String) -> SWCharacter? {

    return coreDataController.load(characterNamed: characterNamed)

  }

  /*: Searches user's documents and attampts to load all characters already on disk. */
  class func loadAllCharacters() -> [SWCharacter] {

    return coreDataController.loadAllCharacters()

  }

  class func delete(character: SWCharacter) -> Bool {

    return coreDataController.delete(character: character)

  }

  class func deleteAllCharacters() -> Bool {

    return coreDataController.deleteAllCharacters()

  }

}

//// MARK: - Migration Code

// TODO: figure migration out later
// - need to de-dupe or only perform migration once.

//private extension SWDataController {
//
//  /*: Private path to user's documents directory. */
//  private static let documentsDirectory: String = {
//    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//    let documentDirectory = paths[0] as String
//    return documentDirectory
//  }()
//
//  class func loadAllCharactersFromLegacyStorage() -> [SWCharacter] {
//    var characters = [SWCharacter]()
//    do {
//      let directoryContents = try FileManager.default.contentsOfDirectory(atPath: documentsDirectory)
//      let characterFiles = directoryContents.filter{ $0.hasSuffix(".character") }
//      let characterNames = characterFiles.flatMap { $0.components(separatedBy: ".").first } //
//      let loadedCharacters = characterNames.flatMap { load(characterNamed: $0) }
//      characters = loadedCharacters
//    }
//    catch {
//      return [] // just return empty if we catch an error.
//    }
//    return characters
//  }
//
//  class func migrateCharactersFromLegacyStorage() -> Bool {
//    let characters = loadAllCharactersFromLegacyStorage()
//    var success = true
//    for character in characters {
//      if !save(character: character) {
//        success = false
//      }
//    }
//    return success
//  }
//
//}

// MARK: - Private JSON Encoding/Decoding Helpers

fileprivate extension DateFormatter {

  /// Apple's implementation of ISO 8601 is incomplete.
  /// - see: https://useyourloaf.com/blog/swift-codable-with-custom-dates/
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()

}

fileprivate extension JSONDecoder {

  /// A shared JSON decoder to allow for easy decoding strategy adjustments.
  static let shared: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(.iso8601Full)
    return decoder
  }()

}

fileprivate extension JSONEncoder {

  /// A shared JSON encoder to allow for easy decoding strategy adjustments.
  static let shared: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .formatted(.iso8601Full)
    return encoder
  }()

}
