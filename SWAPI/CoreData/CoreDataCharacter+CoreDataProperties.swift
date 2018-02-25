//
//  CoreDataCharacter+CoreDataProperties.swift
//  SWAPI
//
//  Created by Blake Merryman on 2/24/18.
//  Copyright © 2018 Blake Merryman. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataCharacter {

  @nonobjc public class func fetchAll() -> NSFetchRequest<CoreDataCharacter> {
    return NSFetchRequest<CoreDataCharacter>(entityName: "CoreDataCharacter")
  }

  @nonobjc public class func fetch(forCharacterNamed name: String) -> NSFetchRequest<CoreDataCharacter> {
    let request = NSFetchRequest<CoreDataCharacter>(entityName: "CoreDataCharacter")
    request.predicate = NSPredicate(format: "name == %@", name)
    return request
  }

  @nonobjc public class func deleteAll() -> NSBatchDeleteRequest {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataCharacter")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    return deleteRequest
  }

  @NSManaged public var birthYear: String?
  @NSManaged public var created: NSDate?
  @NSManaged public var edited: NSDate?
  @NSManaged public var eyeColor: String?
  @NSManaged public var gender: String?
  @NSManaged public var hairColor: String?
  @NSManaged public var height: String?
  @NSManaged public var mass: String?
  @NSManaged public var name: String?
  @NSManaged public var skinColor: String?
  @NSManaged public var url: URL?

}
