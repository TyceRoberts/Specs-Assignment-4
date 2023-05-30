//
//  CoreDataManager.swift
//  DMFindingGame
//
//  Created by tyce roberts on 5/19/23.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Main")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    /**
     Add the passed score to CoreData.
     */
    func addScore(score: Int) {
        let context = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "ScoreEntity", in: context) else {
            return
        }
        let newScore = NSManagedObject(entity: entity, insertInto: context)
        newScore.setValue(score, forKey: "score")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    /**
     Retrieve all the scores from CoreData.
     */
    func fetchScores() -> [Int] {
        let context = persistentContainer.viewContext
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ScoreEntity")

           do {
               let result = try context.fetch(request)
               return result.compactMap { $0 as? NSManagedObject }
                   .compactMap { $0.value(forKey: "score") as? Int }
           } catch {
               print("Failed to fetch scores")
           }
        return []
    }
    
    /**
     Calculate the high score.
     */
    func calculateHighScore() -> [Int] {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ScoreEntity")
        
        do {
            let result = try context.fetch(request)
            return result.compactMap { $0 as? NSManagedObject }
                .compactMap { $0.value(forKey: "score") as? Int }
        } catch {
            print("Failed to fetch scores")
        }
        return []
    }
}

