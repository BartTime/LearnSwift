//
//  User+CoreDataProperties.swift
//  LearnSwift
//
//  Created by Alex on 22.04.2023.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var gmail: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
