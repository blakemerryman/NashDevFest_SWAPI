//
//  CoreDataController.swift
//  SWAPI
//
//  Created by Blake Merryman on 2/24/18.
//  Copyright © 2018 Blake Merryman. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Core Data

final class CoreDataController {

  // MARK: - Properties

  private let modelName: String

  // MARK: - Initialization

  init(modelName: String) {
    self.modelName = modelName
  }

  // MARK: - Public API

  func save(_ swCharacter: SWCharacter) -> Bool {

    guard let coreDataCharacter = NSEntityDescription.insertNewObject(forEntityName: "CoreDataCharacter",
                                                                      into: self.managedObjectContext) as? CoreDataCharacter else {
      return false
    }

    coreDataCharacter.configure(with: swCharacter)

    do {
      try managedObjectContext.save()
      return true
    }
    catch {
      return false
    }
  }

  func load(characterNamed name: String) -> SWCharacter? {

    let fetchRequest = CoreDataCharacter.fetch(forCharacterNamed: name)

    do {
      return try managedObjectContext.fetch(fetchRequest).first?.toSWCharacter()
    }
    catch {
      return nil
    }
  }

  func loadAllCharacters() -> [SWCharacter] {

    let fetchRequest = CoreDataCharacter.fetchAll()

    do {
      let characters = try managedObjectContext.fetch(fetchRequest)
        .map { $0.toSWCharacter() }
        .flatMap { $0 }

      return characters
    }
    catch {
      return []
    }
  }

  func delete(character: SWCharacter) -> Bool {

    let fetchRequest = CoreDataCharacter.fetch(forCharacterNamed: character.name)

    do {
      if let cdCharacter = try managedObjectContext.fetch(fetchRequest).first {
        managedObjectContext.delete(cdCharacter)
      }
      return true
    }
    catch {
      return false
    }
  }

  func deleteAllCharacters() -> Bool {

    let deleteRequest = CoreDataCharacter.deleteAll()

    do {
      try persistentStoreCoordinator.execute(deleteRequest, with: managedObjectContext)
      return true
    }
    catch {
      return false
    }
  }

  // MARK: - Core Data Stack

  private(set) lazy var managedObjectContext: NSManagedObjectContext = {
    let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

    return managedObjectContext
  }()

  private lazy var managedObjectModel: NSManagedObjectModel = {
    guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
      fatalError("Unable to Find Data Model")
    }

    guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
      fatalError("Unable to Load Data Model")
    }

    return managedObjectModel
  }()

  private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

    let fileManager = FileManager.default
    let storeName = "\(self.modelName).sqlite"

    let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

    let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)

    do {
      try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                        configurationName: nil,
                                                        at: persistentStoreURL,
                                                        options: nil)
    } catch {
      fatalError("Unable to Load Persistent Store")
    }

    return persistentStoreCoordinator
  }()

}
