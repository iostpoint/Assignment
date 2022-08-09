//
//  Garment+CoreDataProperties.swift
//  LululemonAssignment
//
//  Created by Vivek  on 09/08/2022
//
//

import Foundation
import CoreData


extension Garment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Garment> {
        return NSFetchRequest<Garment>(entityName: "Garment")
    }

    @NSManaged public var creationTime: Date?
    @NSManaged public var name: String?

}

extension Garment : Identifiable {

}
