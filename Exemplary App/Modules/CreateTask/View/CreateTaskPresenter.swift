//
//  CreateTaskPresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import Foundation

protocol CreateTaskOutput {
    func viewIsReady()
    func didTapCreateButton()
    func didTapDateButton()
    func didChangeTitle(_ text: String?)
    func didChaneDescription(_ text: String?)
}

class CreateTaskPresenter {
    
    weak var view: CreateTaskInput?
    
    private let router: CreateTaskRouter.Routes
    
    var output: CreateTaskModuleOutput?
    
    private var task: Task
    
    init(router: CreateTaskRouter.Routes) {
        self.router = router
        task = Task(title: nil, description: nil, date: TaskDate(date: Date()), status: nil)
    }
    
    // Replace or make it pretty
    private func updateTimeButton() {
        if let date = task.date?.date {
            if let withTime = task.date?.withTime, withTime == true {
                if Calendar.current.isDateInToday(date) {
                    view?.setTimeButtonTitle(with: R.string.localizable.commonToday() + " " +
                                             DateFormatter.displayTimeFormatter.string(from: date))
                } else if Calendar.current.isDateInTomorrow(date) {
                    view?.setTimeButtonTitle(with: R.string.localizable.commonTomorrow() + " " +
                                             DateFormatter.displayTimeFormatter.string(from: date))
                } else {
                    view?.setTimeButtonTitle(with: DateFormatter.displayDayFormatter.string(from: date) + " " +
                                             DateFormatter.displayTimeFormatter.string(from: date))
                }
            } else {
                if Calendar.current.isDateInToday(date) {
                    view?.setTimeButtonTitle(with: R.string.localizable.commonToday())
                } else if Calendar.current.isDateInTomorrow(date) {
                    view?.setTimeButtonTitle(with: R.string.localizable.commonToday())
                } else {
                    view?.setTimeButtonTitle(with: DateFormatter.displayDayFormatter.string(from: date))
                }
            }
        } else {
            view?.setTimeButtonTitle(with: R.string.localizable.selectDateButtonTitleAddTime())
        }
    }
}

extension CreateTaskPresenter: CreateTaskOutput {
    func viewIsReady() {
        updateTimeButton()
    }
    func didTapCreateButton() {
        output?.didCreateTask(task)
        router.close()
    }
    
    func didTapDateButton() {
        router.openSelectDateModule(config: .init(taskDate: task.date, updateTime: { [weak self] taskDate in
            self?.task.date = taskDate
            self?.updateTimeButton()
        }))
    }
    
    func didChangeTitle(_ text: String?) {
        task.title = text
    }
    
    func didChaneDescription(_ text: String?) {
        task.description = text
    }
}
