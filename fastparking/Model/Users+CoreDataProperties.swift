//
//  Users+CoreDataProperties.swift
//  
//
//  Created by Jose Veliz on 6/25/19.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: Int16
    @NSManaged public var lastName: String?
    @NSManaged public var address: String?
    @NSManaged public var birthday: String?
    @NSManaged public var dni: String?
    @NSManaged public var ruc: String?
    @NSManaged public var activeField: Bool
    @NSManaged public var totalAmount: Int32
    @NSManaged public var balance: Int32
    @NSManaged public var fullName: String?
    @NSManaged public var password: String?

}
