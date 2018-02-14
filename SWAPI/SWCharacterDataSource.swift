//
//  SWCharacterDataSource.swift
//  SWAPI
//
//  Created by Blake Merryman on 1/28/17.
//  Copyright © 2017 Blake Merryman. All rights reserved.
//

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

  /*: Index that keeps track of next character to request from API. */
  private var nextAPICharacterIndex = 0

  /*: Variable to store locally cached Characters. */
  private(set) var characters: [SWCharacter] = []

  private var requesting: Bool = false

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

    guard !requesting else {
      return // abort! we're already making a request
    }

    requesting = true

    get("/people/\(nextAPICharacterIndex)") { data, response, error in

      self.requesting = false

      guard let data = data else {
        return // TODO: awesome error handling here
      }

      guard let newCharacter = SWDataController.createCharacter(from: data) else {
        return // TODO: awesome error handling here
      }

      if SWDataController.save(character: newCharacter) {
        self.characters.append(newCharacter)
        self.nextAPICharacterIndex += 1
        DispatchQueue.main.async {
          self.delegate?.didUpdate(dataSource: self)
        }
      }
    }
  }

}
