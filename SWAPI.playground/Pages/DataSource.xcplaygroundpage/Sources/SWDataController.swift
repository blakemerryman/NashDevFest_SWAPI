import Foundation

/*:
 # A Simple Data Controller

 - Our model conforms to `NSCoding` but can't actually persist itself.

 - DataController handles reading-data-from and writing-data-to disk.

 - Wrapping `NSKeyedArchiver`/`NSKeyedUnarchiver` allows us to simplify the interface while ensuring proper model typing.

 */

public class SWDataController {

  /*: Private path to user's documents directory. */
  private static let documentsDirectory: String = {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentDirectory = paths[0] as String
    return documentDirectory
  }()

  /*: Attempts to a create a character object. */
  public class func createCharacter(fromJSON json: [String: AnyObject]) -> SWCharacter? {

    return SWCharacter(fromJSON: json)
  }

  /*: Attempts to save a character object to disk. */
  public class func save(character: SWCharacter) -> Bool {
    let characterPath = documentsDirectory.appending("/\(character.name).character")
    let success = NSKeyedArchiver.archiveRootObject(character, toFile: characterPath)
    return success
  }

  /*: Attempts to load a character using it's name (i.e. used as filename). */
  public class func load(characterNamed: String) -> SWCharacter? {
    let characterPath = documentsDirectory.appending("/\(characterNamed).character")
    let character = NSKeyedUnarchiver.unarchiveObject(withFile: characterPath)
    return character as? SWCharacter
  }

  /*: Searches user's documents and attampts to load all characters already on disk. */
  public class func loadAllCharacters() -> [SWCharacter] {
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
