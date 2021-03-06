//
//  SWCharacter.swift
//  SWAPI
//
//  Created by Blake Merryman on 1/28/17.
//  Copyright © 2017 Blake Merryman. All rights reserved.
//

import Foundation

/**
 # A Simple Data Model with Persistence Support

 ```
 {
   "birth_year" = 19BBY;
   created = "2014-12-09T13:50:51.644000Z";
   edited = "2014-12-20T21:17:56.891000Z";
   "eye_color" = blue;
   films = (
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
   species = (
     "http://swapi.co/api/species/1/"
   );
   starships = (
     "http://swapi.co/api/starships/12/",
     "http://swapi.co/api/starships/22/"
   );
   url = "http://swapi.co/api/people/1/";
   vehicles = (
     "http://swapi.co/api/vehicles/14/",
     "http://swapi.co/api/vehicles/30/"
   );
 }
 ```
 */
class SWCharacter: NSObject, Codable {

  let name: String
  let eyeColor: String
  let url: String
  // Add more properties here as desired.

  /*: Designated initializer. */
  init(name: String, eyeColor: String, url: String) {
    self.name = name
    self.eyeColor = eyeColor
    self.url = url
    super.init()
  }

  enum CodingKeys: String, CodingKey {
    case name, eyeColor = "eye_color", url
  }
}
