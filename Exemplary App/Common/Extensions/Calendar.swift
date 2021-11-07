//
//  Calendar.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 07/11/2021.
//

import Foundation

extension Calendar {
    func isDate(_ date: Date, inSameMonthAs compareDate: Date) -> Bool {
        return isDate(date, equalTo: compareDate, toGranularity: .month)
    }
}
