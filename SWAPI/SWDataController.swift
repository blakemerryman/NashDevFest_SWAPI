//
//  SWDataController.swift
//  SWAPI
//
//  Created by Blake Merryman on 1/28/17.
//  Copyright © 2017 Blake Merryman. All rights reserved.
//

import Foundation

/*:
 # A Simple Data Controller

 - Our model conforms to `NSCoding` but can't actually persist itself.

 - DataController handles reading-data-from and writing-data-to disk.

 - Wrapping `Encodable`/`Decodable` allows us to simplify the interface while ensuring proper model typing.

 */
class SWDataController {

  /*: Private path to user's documents directory. */
  private static let documentsDirectory: String = {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentDirectory = paths[0] as String
    return documentDirectory
  }()

  /*: Attempts to a create a character object. */
  class func createCharacter(from data: Data) -> SWCharacter? {

    return try? JSONDecoder.shared.decode(SWCharacter.self, from: data)
  }

  /*: Attempts to save a character object to disk. */
  class func save(character: SWCharacter) -> Bool {

    let characterPath = documentsDirectory.appending("/\(character.name).character")
    let characterURL = URL(fileURLWithPath: characterPath)

    guard let characterData = try? JSONEncoder.shared.encode(character) else {
      return false // Encoding to data failed.
    }

    do {
      try characterData.write(to: characterURL)
      return true
    }
    catch {
      return false
    }
  }

  /*: Attempts to load a character using it's name (i.e. used as filename). */
  class func load(characterNamed: String) -> SWCharacter? {

    let characterPath = documentsDirectory.appending("/\(characterNamed).character")
    let characterURL = URL(fileURLWithPath: characterPath)

    guard let possibleCharacterData = try? Data(contentsOf: characterURL) else {
      return nil // No character data at the path.
    }

    return createCharacter(from: possibleCharacterData)
  }

  /*: Searches user's documents and attampts to load all characters already on disk. */
  class func loadAllCharacters() -> [SWCharacter] {
    var characters = [SWCharacter]()
    do {
      let directoryContents = try FileManager.default.contentsOfDirectory(atPath: documentsDirectory)
      let characterFiles = directoryContents.filter{ $0.hasSuffix(".character") }
      let characterNames = characterFiles.flatMap { $0.components(separatedBy: ".").first } //
      let loadedCharacters = characterNames.flatMap { load(characterNamed: $0) }
      characters = loadedCharacters
    }
    catch {
      return [] // just return empty if we catch an error.
    }
    return characters
  }

}

fileprivate extension JSONDecoder {

  /// A shared JSON decoder to allow for easy decoding strategy adjustments.
  static let shared: JSONDecoder = {
    let decoder = JSONDecoder()
    return decoder
  }()

}

fileprivate extension JSONEncoder {

  /// A shared JSON encoder to allow for easy decoding strategy adjustments.
  static let shared: JSONEncoder = {
    let encoder = JSONEncoder()
    return encoder
  }()

}
