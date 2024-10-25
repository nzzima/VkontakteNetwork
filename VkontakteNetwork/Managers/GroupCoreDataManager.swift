//
//  GroupCoreDataManager.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 25.10.2024.
//

import Foundation
import CoreData
import SwiftUICore

class GroupCoreDataManager: ObservableObject {
    
    static let shared = GroupCoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "GroupCoreDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("GroupCoreData Store failed! \(error.localizedDescription)")
            }
        }
    }
    
    func saveGroup(groupModel: Group) {
        let group = GroupCore(context: persistentContainer.viewContext)
        
        group.name = groupModel.name
        group.photo = groupModel.photo
        
        do {
            try persistentContainer.viewContext.save()
            print("Group saved to core!")
        } catch {
            print("Failed to save group \(error)")
        }
    }
    
    func takeGroup(/*lastName: String*/) -> [GroupCore]? {
        let fetchRequest: NSFetchRequest<GroupCore> = GroupCore.fetchRequest()
        //fetchRequest.predicate = NSPredicate(format: "lastName == %@", lastName)
        let result = try? persistentContainer.viewContext.fetch(fetchRequest)
//        let friend = result?.first
//        return friend
        return result
    }
    
    func updateGroups(newGroups: [Group]) {
        let coreGroups = takeGroup(/*lastName: friend.lastName*/)
        for coreGroup in coreGroups ?? [] {
            for group in newGroups {
                if coreGroup.name == group.name {
                    coreGroup.photo = group.photo
                }
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
    
//    func deleteAllCoreData() {
//        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = FriendCore.fetchRequest()
//              let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
//        _ = try? persistentContainer.viewContext.execute(batchDeleteRequest1)
//        try? persistentContainer.viewContext.save()
//    }
}
