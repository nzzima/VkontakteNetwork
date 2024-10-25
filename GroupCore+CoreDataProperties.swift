//
//  GroupCore+CoreDataProperties.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 25.10.2024.
//

import Foundation
import CoreData


extension GroupCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupCore> {
        return NSFetchRequest<GroupCore>(entityName: "GroupCore")
    }

    @NSManaged public var photo: String?
    @NSManaged public var name: String?

}

extension GroupCore : Identifiable {

}
