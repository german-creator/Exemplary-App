//
//  Task+CoreDataClass.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 21/11/2021.
//

import CoreStore
import SwiftyJSON

@objc(Task)
public class Task: NSManagedObject {
}

extension Task: ImportableUniqueObject {
    
    enum Status {
        case base, overdue, completed
    }
    
    public typealias UniqueIDType = String
    public typealias ImportSource = JSON
    
    public static var uniqueIDKeyPath: String {
        return "id" //#keyPath(User.id)
    }
    
    public static func uniqueID(from source: ImportSource, in transaction: BaseDataTransaction) throws -> String? {
        return source["id"].string
    }
    
    public func update(from source: ImportSource, in transaction: BaseDataTransaction) throws {
        id = source["id"].string ?? ""
        title = source["title"].string ?? ""
        subtitle = source["subtitle"].string ?? ""
        isComplete = source["isComplete"].bool ?? false
        try taskDate = transaction.importObject(Into<TaskDate>(), source: source["taskDate"])
    }
}

extension Task {
    var status: Status? {
        guard !isComplete else { return .completed }
        guard let date = taskDate,
              let day = date.day else { return .base }
        
        if Calendar.current.isDateInToday(day) {
            if let time = date.time,
               time < Date() {
                return .overdue
            } else {
                return .base
            }
        } else if day > Date() {
            return .base
        } else {
            return .overdue
        }
    }
}
