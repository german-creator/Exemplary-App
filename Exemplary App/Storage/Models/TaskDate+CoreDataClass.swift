//
//  TaskDate.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 22/11/2021.
//

import CoreStore
import SwiftyJSON

@objc(TaskDate)
public class TaskDate: NSManagedObject {
}

extension TaskDate: ImportableObject {
 
    public typealias ImportSource = JSON
    
    public func didInsert(from source: JSON, in transaction: BaseDataTransaction) throws {
        dayRaw = source["day"].string ?? ""
        timeRaw = source["time"].string ?? ""
    }
}

extension TaskDate {
    var day: Date? {
        return dayRaw.flatMap(DateFormatter.serverDateFormatter.date)
    }
    
    var time: Date? {
        return timeRaw.flatMap(DateFormatter.serverDateFormatter.date)
    }
    
    var displayFormate: String? {
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
        
        if timeString != nil || dayString != nil {
            return (dayString ?? "") + (timeString ?? "")
        } else {
            return nil
        }
    }
}


