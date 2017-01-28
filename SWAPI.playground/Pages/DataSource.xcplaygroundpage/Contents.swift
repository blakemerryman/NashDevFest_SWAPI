import Foundation
/*:
 # DataSource
 
 - A data source ties our networking, model, & persistence code all together in a unified interface.

 */

/*:
 A simple delegate protocol to allow the data source to notify owning view controller that new data is ready.
 */
protocol SWCharacterDataSourceDelegate {
  func didUpdate(dataSource: SWCharacterDataSource) -> Void
}


class SWCharacterDataSource: StarWarsInterface {

  var delegate: SWCharacterDataSourceDelegate?

  private var nextAPICharacterIndex = 0

  private(set) var characters: [SWCharacter] = []












  /*: At initialization, we load up any Characters that are already on disk and prep index for next API call. */
  init() {
    characters = SWDataController.loadAllCharacters()
    nextAPICharacterIndex = characters.count + 1
  }













  /*: 
   The `loadNext()` method wraps up the following:
   - Kicks off an API request for the next character.
   - Creates Character from response JSON.
   - Saves Character to disk and updates datasource cache/index.
   - Notify the delegate that new data is available.
   */
  func loadNext() {
    get("/people/\(nextAPICharacterIndex)") { data, response, error in
      guard let characterJSON = JSONHelper.shared.decodeJSON(fromData: data),
        let newCharacter = SWDataController.createCharacter(fromJSON: characterJSON)
        else  { return }

      if SWDataController.save(character: newCharacter) {
        self.characters.append(newCharacter)
        self.nextAPICharacterIndex += 1
        self.delegate?.didUpdate(dataSource: self)
      }
    }
  }

}

//: [Persistence](@previous)  |  [ViewController](@next)
