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
        persistentContainer.loadPersistentStores { (_, error) in
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
    func takeGroup() -> [GroupCore]? {
        let fetchRequest: NSFetchRequest<GroupCore> = GroupCore.fetchRequest()
        let result = try? persistentContainer.viewContext.fetch(fetchRequest)
        return result
    }
    func updateGroups(newGroups: [Group]) {
        let coreGroups = takeGroup()
        for coreGroup in coreGroups ?? [] {
            for group in newGroups where coreGroup.name == group.name {
                coreGroup.photo = group.photo
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
}
