//
//  Date.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 04/11/2021.
//

import Foundation

extension Date {
    static var tomorrow:  Date { return Date().dayAfter }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    func withTime(frome date: Date) -> Date {
        let hour = Calendar.current.component(.hour, from: date)
        let minuter = Calendar.current.component(.minute, from: date)
        return Calendar.current.date(bySettingHour: hour, minute: minuter, second: 0, of: self)!
    }
}
