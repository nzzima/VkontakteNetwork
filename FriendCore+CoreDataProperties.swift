//
//  FriendCore+CoreDataProperties.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 04.10.2024.
//
//

import Foundation
import CoreData

extension FriendCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendCore> {
        return NSFetchRequest<FriendCore>(entityName: "FriendCore")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var photo: String?
    @NSManaged public var status: Int64

}

extension FriendCore: Identifiable {}
