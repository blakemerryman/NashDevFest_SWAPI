//
//  CoreDataCharacter+CoreDataClass.swift
//  SWAPI
//
//  Created by Blake Merryman on 2/24/18.
//  Copyright © 2018 Blake Merryman. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CoreDataCharacter)
public class CoreDataCharacter: NSManagedObject {

}

extension CoreDataCharacter {

  func configure(with character: SWCharacter) {
    self.url = character.url
    self.created = character.created as NSDate
    self.edited = character.edited as NSDate
    self.name = character.name
    self.birthYear = character.birthYear
    self.gender = character.gender
    self.eyeColor = character.eyeColor
    self.hairColor = character.hairColor
    self.skinColor = character.skinColor
    self.height = character.height
    self.mass = character.mass
  }

  func toSWCharacter() -> SWCharacter? {
    guard
      let url = self.url,
      let created = self.created,
      let edited = self.edited,
      let name = self.name,
      let birthYear = self.birthYear,
      let gender = self.gender,
      let eyeColor = self.eyeColor,
      let hairColor = self.hairColor,
      let skinColor = self.skinColor,
      let height = self.height,
      let mass = self.mass
      else { return nil }

    return SWCharacter(url: url,
                       created: created as Date,
                       edited: edited as Date,
                       name: name,
                       birthYear: birthYear,
                       gender: gender,
                       eyeColor: eyeColor,
                       hairColor: hairColor,
                       skinColor: skinColor,
                       height: height,
                       mass: mass)
  }

}
