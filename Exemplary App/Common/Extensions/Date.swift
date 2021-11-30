//
//  Date.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 04/11/2021.
//

import Foundation

extension Date {
    static var tomorrow: Date { return Date().dayAfter }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
}
