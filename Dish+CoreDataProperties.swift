//
//  Dish+CoreDataProperties.swift
//  littlelemon_app
//
//  Created by amruta on 14/03/23.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var price: String?
    @NSManaged public var category: String?

}

extension Dish : Identifiable {

}
