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

  let url: String
  let created: Date
  let edited: Date

  let name: String
  let birthYear: String
  let gender: String
  let eyeColor: String
  let hairColor: String
  let skinColor: String
  let height: String
  let mass: String

  // Add more properties here as desired.

  /*: Designated initializer. */
  init(url: String,
       created: Date,
       edited: Date,
       name: String,
       birthYear: String,
       gender: String,
       eyeColor: String,
       hairColor: String,
       skinColor: String,
       height: String,
       mass: String) {

    self.url = url
    self.created = created
    self.edited = edited
    self.name = name
    self.birthYear = birthYear
    self.gender = gender
    self.eyeColor = eyeColor
    self.hairColor = hairColor
    self.skinColor = skinColor
    self.height = height
    self.mass = mass

    super.init()
  }

  // MARK: - Coding Keys
  // We need this only so we can override the JSON key name.
  enum CodingKeys: String, CodingKey {
    case url
    case created
    case edited
    case name
    case birthYear = "birth_year"
    case gender
    case eyeColor = "eye_color"
    case hairColor = "hair_color"
    case skinColor = "skin_color"
    case height
    case mass
  }

}
