//
//  CoreDataManager.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 30.09.2024.
//

import Foundation
import CoreData

class CoreDataManager: NSObject, ObservableObject {
    
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    override init() {
        persistentContainer = NSPersistentContainer(name: "FriendCoreDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("CoreData Store failed! \(error.localizedDescription)")
            }
        }
    }
    
    func saveFriend(friendModel: Friend) {
        let friend = FriendCore(context: persistentContainer.viewContext)
        friend.firstName = friendModel.firstName
        friend.lastName = friendModel.lastName
        friend.photo = friendModel.photo
        friend.status = Int64(friendModel.online)
        
        do {
            try persistentContainer.viewContext.save()
            print("Friend saved to core!")
        } catch {
            print("Failed to save friend \(error)")
        }
    }
    
    func deleteAllCoreData() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = FriendCore.fetchRequest()
              let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? persistentContainer.viewContext.execute(batchDeleteRequest1)
        try? persistentContainer.viewContext.save()
    }
}
