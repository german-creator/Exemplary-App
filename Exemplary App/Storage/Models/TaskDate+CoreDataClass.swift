//
//  TaskDate.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 22/11/2021.
//

import CoreStore

@objc(TaskDate)
public class TaskDate: NSManagedObject {
}

extension TaskDate: ImportableObject {
 
    public typealias ImportSource = [String: Any]
    
    public func didInsert(from source: [String: Any], in transaction: BaseDataTransaction) throws {
        day = source["day"] as? Date
        time = source["time"] as? Date
    }
}

extension TaskDate {    
    var displayFormat: String? {
        var timeString: String?
        var dayString: String?
        
        if let time = time {
            timeString = " " + DateFormatter.displayTimeFormatter.string(from: time)
        }
        
        if let day = day {
            if Calendar.current.isDateInToday(day) {
                dayString = R.string.localizable.commonToday()
            } else if Calendar.current.isDateInTomorrow(day) {
                dayString = R.string.localizable.commonTomorrow()
            } else {
                dayString = DateFormatter.displayDayFormatter.string(from: day)
            }
        }
        
        guard timeString != nil || dayString != nil else { return nil }
        
        return (dayString ?? "") + (timeString ?? "")
    }
}
