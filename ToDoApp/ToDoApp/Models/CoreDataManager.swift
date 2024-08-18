//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by Suji Jang on 8/18/24.
//

import Foundation

struct CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    func getTodoListFormCoreData() -> [ToDoData] {
        return []
    }
}
