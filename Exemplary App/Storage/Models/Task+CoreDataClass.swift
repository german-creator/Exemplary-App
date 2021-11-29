//
//  Task+CoreDataClass.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 21/11/2021.
//

import CoreStore

@objc(Task)
public class Task: NSManagedObject {
}

extension Task: ImportableUniqueObject {
    
    enum Status {
        case base, overdue, completed
    }
    
    public typealias UniqueIDType = String
    public typealias ImportSource = [String: Any]
    
    public static var uniqueIDKeyPath: String {
        return "id"
    }
    
    public static func uniqueID(from source: ImportSource, in transaction: BaseDataTransaction) throws -> String? {
        return source["id"] as? String
    }
    
    public func update(from source: ImportSource, in transaction: BaseDataTransaction) throws {
        title = source["title"] as? String
        subtitle = source["subtitle"] as? String
        isComplete = source["isComplete"] as? Bool ?? false
        if let date = source["taskDate"] as? [String: Any] {
            try taskDate = transaction.importObject(Into<TaskDate>(), source: date)
        }
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
