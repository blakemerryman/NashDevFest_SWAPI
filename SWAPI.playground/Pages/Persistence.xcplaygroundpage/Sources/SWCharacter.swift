/*:
 # A Simple Data Model with Persistence Support

 ```
 {
 "birth_year" = 19BBY;
 created = "2014-12-09T13:50:51.644000Z";
 edited = "2014-12-20T21:17:56.891000Z";
 "eye_color" = blue;
 films =         (
 "http://swapi.co/api/films/6/",
 "http://swapi.co/api/films/3/",
 "http://swapi.co/api/films/2/",
 "http://swapi.co/api/films/1/",
 "http://swapi.co/api/films/7/"
 );
 gender = male;
 "hair_color" = blond;
 height = 172;
 homeworld = "http://swapi.co/api/planets/1/";
 mass = 77;
 name = "Luke Skywalker";
 "skin_color" = fair;
 species =         (
 "http://swapi.co/api/species/1/"
 );
 starships =         (
 "http://swapi.co/api/starships/12/",
 "http://swapi.co/api/starships/22/"
 );
 url = "http://swapi.co/api/people/1/";
 vehicles =         (
 "http://swapi.co/api/vehicles/14/",
 "http://swapi.co/api/vehicles/30/"
 );
 }
 ```
 */

import Foundation

public class SWCharacter: NSObject, NSCoding {

  public let name: String
  public let eyeColor: String
  public let url: String
  // Add more properties here as desired.

  /*: Designated initializer. */
  public init(name: String, eyeColor: String, url: String) {
    self.name = name
    self.eyeColor = eyeColor
    self.url = url
    super.init()
  }

  /*: Convenience initializer used to create instance from JSON dictionary. */
  public convenience init?(fromJSON json: [String: AnyObject]) {
    guard let name = json["name"] as? String,
      let eyeColor = json["eye_color"] as? String,
      let url = json["url"] as? String else {
        return nil
    }
    self.init(name: name, eyeColor: eyeColor, url: url)
  }


  /*:
   ## Conforming to `NSCoding` allows the model to supply it's own information for persistence.
   ---

   ### `init(code:)` allows model to provide info it needs to be initialized from disk.
   Convenience initializer used by NSCoding to deserialize raw data on disk into an object.
   Required if conforming to NSCoding.
   */
  public required convenience init?(coder aDecoder: NSCoder) {
    guard let storedName = aDecoder.decodeObject(forKey: "name") as? String,
      let storedHome = aDecoder.decodeObject(forKey: "eye_color") as? String,
      let storedURL  = aDecoder.decodeObject(forKey: "url") as? String else {
        return nil
    }

    self.init(name: storedName, eyeColor: storedHome, url: storedURL)
  }

  /*:
   ### `encode(with:)` allows model to provide info it needs to be written to disk.
   Helper method used by NSCoding to serialize object into data for storing on disk.
   Required if conforming to NSCoding.
   */
  public func encode(with aCoder: NSCoder) {
    aCoder.encode(self.name, forKey: "name")
    aCoder.encode(self.eyeColor, forKey: "eye_color")
    aCoder.encode(self.url, forKey: "url")
  }

}

//: [NetworkInterface](@previous)  |  [Persistence](@next)

