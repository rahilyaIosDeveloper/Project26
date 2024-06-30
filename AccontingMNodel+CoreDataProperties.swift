//
//  AccontingMNodel+CoreDataProperties.swift
//  Project26
//
//  Created by Rahilya Nazaralieva on 24/6/24.
//
//

import Foundation
import CoreData


extension AccontingMNodel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccontingMNodel> {
        return NSFetchRequest<AccontingMNodel>(entityName: "AccontingMNodel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var amount: Double
    @NSManaged public var data: Date?
    @NSManaged public var category: String?
    @NSManaged public var image: String?
    @NSManaged public var color: String?

}

extension AccontingMNodel : Identifiable {

}
