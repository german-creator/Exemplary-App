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
    
    mutating func set(with task: Task) {
        id = task.id
        title = task.title
        subtitle = task.subtitle
        isComplete = task.isComplete
        if let task = task.taskDate {
            taskDate = .init(day: task.day, time: task.time)
        }
    }
}
