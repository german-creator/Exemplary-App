//
//  SelectDatePresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 28/10/2021.
//

import Foundation

typealias TaskDateHandler = (TaskCreation.TaskDateCreation?) -> Void

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

final class SelectDatePresenter {
    
    weak var view: SelectDateViewInput?
    
    private let router: SelectDateRouter.Routes
    
    private var config: SelectDateModuleConfig
    private var taskDate: TaskCreation.TaskDateCreation

    init(router: SelectDateRouter.Routes, config: SelectDateModuleConfig) {
        self.router = router
        self.config = config
        self.taskDate = config.taskDate ?? TaskCreation.TaskDateCreation(day: Date(), time: nil)
    }
    
    private func updateTimeButtonTitle() {
        if let time = taskDate.time {
            view?.setTimeButtonTitle(with: DateFormatter.displayTimeFormatter.string(from: time))
        } else {
            view?.setTimeButtonTitle(with: R.string.localizable.selectDateButtonTitleAddTime())
        }
    }
    
    private func updateActiveButtons() {
        if let day = taskDate.day {
            view?.setTodayBottonActive(Calendar.current.isDateInToday(day))
            view?.setTomorrowBottonActive(Calendar.current.isDateInTomorrow(day))
            view?.setNoDateBottonActive(false)
        } else {
            view?.setTodayBottonActive(false)
            view?.setTomorrowBottonActive(false)
            view?.setNoDateBottonActive(true)
        }
    }
}

extension SelectDatePresenter: SelectDateViewOutput {
    func viewIsReady() {
        view?.setCalendarDate(taskDate.day)
        updateTimeButtonTitle()
        updateActiveButtons()
    }
    
    func didTapTime() {
        view?.showTimePicker(time: taskDate.time)
    }
    
    func didTapSave() {
        if taskDate.day != nil || taskDate.time != nil {
            config.updateTimeHandler(taskDate)
        } else {
            config.updateTimeHandler(nil)
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
