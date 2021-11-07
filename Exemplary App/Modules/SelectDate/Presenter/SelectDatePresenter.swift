//
//  SelectDatePresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 28/10/2021.
//

import Foundation

typealias TaskDateHandler = (TaskDate) -> Void

struct SelectDateModuleConfig {
    var taskDate: TaskDate?
    var updateTime: TaskDateHandler
}

protocol SelectDateViewOutput {
    func viewIsReady()
    func didTapTime()
    func didTapSave()
    func didTapToday()
    func didTapTomorrow()
    func didTapNoDate()
    func didChangeDay(newDay: Date)
    func didChangeTime(newTime: Date)
    func didRemoveTime()
}

class SelectDatePresenter {
    
    weak var view: SelectDateViewInput?
    
    private let router: SelectDateRouter.Routes
    
    private var config: SelectDateModuleConfig
    private var date: Date?
    private var time: Date?
    
    init(router: SelectDateRouter.Routes, config: SelectDateModuleConfig) {
        self.router = router
        self.config = config
        self.date = config.taskDate?.date
        self.time = (config.taskDate?.withTime ?? false) ? config.taskDate?.date : nil
    }
    
    private func updateDateButtons() {
        guard let date = date else {
            date = Date()
            view?.setDateButtonChosen(.today)
            return
        }
        if Calendar.current.isDateInToday(date) {
            view?.setDateButtonChosen(.today)
        } else if Calendar.current.isDateInTomorrow(date) {
            view?.setDateButtonChosen(.tomorrow)
        } else {
            view?.setDateButtonChosen(.other)
        }
    }
}

extension SelectDatePresenter: SelectDateViewOutput {
    func viewIsReady() {
        view?.setCalendarDate(date)
        updateDateButtons()
    }
    
    func didTapTime() {
        view?.showTimePicker(withRemoveButton: time != nil ? true : false)
    }
    
    func didTapSave() {
        var newTaskDate = TaskDate(date: date, withTime: false)
    
        if let time = time, let date = date {
            newTaskDate.withTime = true
            let hour = Calendar.current.component(.hour, from: time)
            let minuter = Calendar.current.component(.minute, from: time)
            newTaskDate.date = Calendar.current.date(
                bySettingHour: hour, minute: minuter, second: 0, of: date)!
        }
    
        config.updateTime(newTaskDate)
        router.close()
    }
    
    func didTapToday() {
        let newDate = Date()
        date = newDate
        view?.setCalendarDate(newDate)
        view?.setDateButtonChosen(.today)
    }
    
    func didTapTomorrow() {
        let tomorrow = Date.tomorrow
        date = tomorrow
        view?.setCalendarDate(tomorrow)
        view?.setDateButtonChosen(.tomorrow)
    }
    
    func didTapNoDate() {
        date = nil
        view?.setCalendarDate(nil)
        view?.setDateButtonChosen(.noDate)
    }
    
    func didChangeDay(newDay: Date) {
        date = newDay
        updateDateButtons()
    }
    
    func didChangeTime(newTime: Date) {
        time = newTime
        let timeDisplayFormat = DateFormatter.displayTimeFormatter.string(from: newTime)
        view?.setTimeButtonTitle(with: timeDisplayFormat)
    }
    
    func didRemoveTime() {
        time = nil
        view?.setTimeButtonTitle(with: nil)
    }
}
