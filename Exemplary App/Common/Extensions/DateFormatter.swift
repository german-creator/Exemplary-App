//
//  DateFormatter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 12.09.2021.
//

import Foundation

extension DateFormatter {
    static let displayDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
}
