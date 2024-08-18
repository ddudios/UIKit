//
//  ToDoData+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Suji Jang on 8/18/24.
//
//

import Foundation
import CoreData


extension ToDoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoData> {
        return NSFetchRequest<ToDoData>(entityName: "ToDoData")
    }

    @NSManaged public var memoText: String?
    @NSManaged public var color: Int64
    @NSManaged public var date: Date?

}

extension ToDoData : Identifiable {

}
