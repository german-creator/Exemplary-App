//
//  TaskPresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import Foundation

protocol TaskOutput {
    func viewIsReady()
    func didTapCreateButton()
    func didTapDateButton()
    func didChangeTitle(_ text: String?)
    func didChaneDescription(_ text: String?)
}

class TaskPresenter {
    
    weak var view: TaskInput?
    
    private let router: TaskRouter.Routes
    
    var output: TaskModuleOutput?
    
    private var task: Task
    
    init(router: TaskRouter.Routes, config: TaskConfig) {
        self.router = router
        switch config.mode {
        case .create:
            self.task = Task(id: "33", title: nil, description: nil, date: TaskDate(date: Date()))
        case .edit(let task):
            self.task = task
        }
        self.output = config.output
    }
    
    // Replace or make it pretty
    private func updateDateButtonTitle() {
        guard let date = task.date?.date else {
            view?.setDateButtonTitle(with: R.string.localizable.selectDateButtonTitleAddTime())
            return
        }
        
        let time = task.date?.withTime ?? false ?
        " " + DateFormatter.displayTimeFormatter.string(from: date) : ""
        
        let day: String
        
        if Calendar.current.isDateInToday(date) {
            day = R.string.localizable.commonToday()
        } else if Calendar.current.isDateInTomorrow(date) {
            day = R.string.localizable.commonTomorrow()
        } else {
            day = DateFormatter.displayDayFormatter.string(from: date)
        }
        
        view?.setDateButtonTitle(with: day + time)
    }
    
    private func updateSaveButtonTitle() {
        
        
        view?.setSaveButtonTitle(with: R.string.localizable.commonCreate())
    }
}

extension TaskPresenter: TaskOutput {
    func viewIsReady() {
        view?.setTask(task: task)
        updateDateButtonTitle()
    }
    func didTapCreateButton() {
        output?.didCreateTask(task)
        router.close()
    }
    
    func didTapDateButton() {
        router.openSelectDateModule(config: .init(taskDate: task.date, updateTime: { [weak self] taskDate in
            self?.task.date = taskDate
            self?.updateDateButtonTitle()
        }))
    }
    
    func didChangeTitle(_ text: String?) {
        task.title = text
    }
    
    func didChaneDescription(_ text: String?) {
        task.description = text
    }
}
