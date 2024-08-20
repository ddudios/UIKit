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
    
    var dataString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }

}

extension ToDoData : Identifiable {

}
