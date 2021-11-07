//
//  Taskk.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 27/10/2021.
//

import Foundation

struct Task {
    enum Status {
        case base, overdue, completed
    }
    
    var title: String?
    var description: String?
    var date: TaskDate?
    var status: Status?
}
