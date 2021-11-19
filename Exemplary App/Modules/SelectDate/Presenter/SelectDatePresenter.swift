//
//  SelectDatePresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 28/10/2021.
//

import Foundation

typealias TaskDateHandler = (TaskDate?) -> Void

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
    private var taskDate: TaskDate

    init(router: SelectDateRouter.Routes, config: SelectDateModuleConfig) {
        self.router = router
        self.config = config
        self.taskDate = config.taskDate ?? TaskDate(day: Date(), time: nil)
    }
    
    private func updateTimeButtonTitle() {
        if let time = taskDate.time {
            view?.setTimeButtonTitle(with: DateFormatter.displayTimeFormatter.string(from: time))
        } else  {
            view?.setTimeButtonTitle(with: R.string.localizable.selectDateButtonTitleAddTime())
        }
    }
    
    private func updateActiveButtons() {
        var activeButton: ActiveDateButton
        if let day = taskDate.day {
            if Calendar.current.isDateInToday(day) {
                activeButton = .today
            } else if Calendar.current.isDateInTomorrow(day) {
                activeButton = .tomorrow
            } else {
                activeButton = .noActive
            }
        } else {
            activeButton = .noDate
        }
        view?.setActiveDateButton(activeButton)
    }
}

extension SelectDatePresenter: SelectDateViewOutput {
    func viewIsReady() {
        view?.setCalendarDate(taskDate.day)
        updateTimeButtonTitle()
        updateActiveButtons()
    }
    
    func didTapTime() {
        view?.showTimePicker(time: taskDate.time ?? Date())
    }
    
    func didTapSave() {
        if taskDate.day != nil || taskDate.time != nil {
            config.updateTime(taskDate)
        } else {
            config.updateTime(nil)
        }
        router.close()
    }
    
    func didTapToday() {
        let today = Date()
        taskDate.day = today
        view?.setCalendarDate(today)
        updateActiveButtons()
    }
    
    func didTapTomorrow() {
        let tomorrow = Date.tomorrow
        taskDate.day = tomorrow
        view?.setCalendarDate(tomorrow)
        updateActiveButtons()
    }
    
    func didTapNoDate() {
        taskDate.day = nil
        view?.setCalendarDate(nil)
        updateActiveButtons()
    }
    
    func didChangeDay(newDay: Date) {
        taskDate.day = newDay
        updateActiveButtons()
    }
    
    func didChangeTime(newTime: Date) {
        taskDate.time = newTime
        updateTimeButtonTitle()
    }
    
    func didRemoveTime() {
        taskDate.time = nil
        updateTimeButtonTitle()
    }
}
