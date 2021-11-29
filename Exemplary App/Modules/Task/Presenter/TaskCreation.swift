//
//  TaskConfig.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18/11/2021.
//

import Foundation

struct TaskCreation {
    var id: String?
    var title: String?
    var subtitle: String?
    var isComplete: Bool?
    var taskDate: TaskDateCreation?
    
    struct TaskDateCreation {
        var day: Date?
        var time: Date?
        
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
        
        func dictionary() -> [String: Any]? {
            guard day != nil || time != nil else { return nil }
            
            return ["day": day as Any, "time": time as Any]
        }
    }
    
    mutating func set(with task: Task) {
        id = task.id
        title = task.title
        subtitle = task.subtitle
        isComplete = task.isComplete
        if let task = task.taskDate {
            taskDate = .init(day: task.day, time: task.time)
        }
    }
    
    func dictionary() -> [String: Any] {
        return ["id": id ?? UUID().uuidString,
                "title": title as Any,
                "subtitle": subtitle as Any,
                "isComplete": isComplete as Any,
                "taskDate": taskDate?.dictionary() as Any] as [String : Any]
    }
}
