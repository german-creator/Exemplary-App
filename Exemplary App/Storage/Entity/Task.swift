//
//  Task.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 27/10/2021.
//

import Foundation

struct Task: Codable {
    enum Status {
        case base, overdue, completed
    }
    
    var id: String
    var title: String?
    var description: String?
    var date: TaskDate?
    var isComplete: Bool = false
    var status: Status? {
        guard !isComplete else { return .completed }
        guard let date = date,
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


struct TaskDate: Codable {
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
