//
//  CoreDataManager.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 30.09.2024.
//

import Foundation
import CoreData

class CoreDataManager: NSObject, ObservableObject {
    
    @Published var friendsCore: [FriendCore] = [FriendCore]()
    let persistentContainer: NSPersistentContainer
    
    override init() {
        persistentContainer = NSPersistentContainer(name: "FriendCoreDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("CoreData Store failed! \(error.localizedDescription)")
            }
        }
    }
    
    func saveFriend(photo: String, firstName: String, lastName: String, status: Int) {
        let friend = FriendCore(context: persistentContainer.viewContext)
        friend.firstName = firstName
        friend.lastName = lastName
        friend.photo = photo
        friend.status = Int64(status)
        
        do {
            try persistentContainer.viewContext.save()
            print("Friend saved to core!")
        } catch {
            print("Failed to save friend \(error)")
        }
    }
    
    func deleteAllCoreData(entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                persistentContainer.viewContext.delete(objectData)
            }
        } catch let error {
            print("Delete all data in \(entity) failed:", error)
        }
    }
}
