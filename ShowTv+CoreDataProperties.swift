//
//  ShowTv+CoreDataProperties.swift
//  TestElerktra
//
//  Created by Luan Road on 02/02/22.
//
//

import Foundation
import CoreData


extension ShowTv {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShowTv> {
        return NSFetchRequest<ShowTv>(entityName: "ShowTv")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var imdb: String?
    @NSManaged public var summary: String?

}
