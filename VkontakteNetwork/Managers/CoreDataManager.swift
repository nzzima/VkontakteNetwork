//
//  CoreDataManager.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 30.09.2024.
//

import Foundation
import CoreData
import SwiftUICore

class CoreDataManager: ObservableObject {
    
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    init() {
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
    
    func takeFriend(lastName: String) -> FriendCore? {
        let fetchRequest: NSFetchRequest<FriendCore> = FriendCore.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "lastName == %@", lastName)
        let result = try? persistentContainer.viewContext.fetch(fetchRequest)
        let friend = result?.first
        return friend
    }
    
    func updateFriends(newFriends: [Friend]) {
        for friend in newFriends {
            let takeFriend = takeFriend(lastName: friend.lastName)
            takeFriend?.firstName = friend.firstName
            takeFriend?.photo = friend.photo
            takeFriend?.status = Int64(friend.online)
        }
        
        do {
            try persistentContainer.viewContext.save()
            print("Friends updated in core!")
        } catch {
            print("Failed to update friends in core: \(error)")
        }
    }
    
    func deleteAllCoreData() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = FriendCore.fetchRequest()
              let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? persistentContainer.viewContext.execute(batchDeleteRequest1)
        try? persistentContainer.viewContext.save()
    }
}
