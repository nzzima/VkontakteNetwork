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
        persistentContainer.loadPersistentStores { (_, error) in
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
    func takeFriend(/*lastName: String*/) -> [FriendCore]? {
        let fetchRequest: NSFetchRequest<FriendCore> = FriendCore.fetchRequest()
        let result = try? persistentContainer.viewContext.fetch(fetchRequest)
        return result
    }
    func updateFriends(newFriends: [Friend]) {
        let coreFriends = takeFriend()
        for coreFriend in coreFriends ?? [] {
            for friend in newFriends where coreFriend.lastName == friend.lastName {
                coreFriend.firstName = friend.firstName
                coreFriend.photo = friend.photo
                coreFriend.status = Int64(friend.online)
            }
        }
        saveToCore()
    }
    func saveToCore() {
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
