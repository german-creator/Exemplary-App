//
//  TaskPresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import Foundation

protocol TaskOutput {
    func viewIsReady()
    func didTapSaveButton()
    func didTapDateButton()
    func didChangeTitle(_ text: String?)
    func didChaneDescription(_ text: String?)
}

class TaskPresenter {
    
    weak var view: TaskInput?
    
    private let router: TaskRouter.Routes
    
    private var config: TaskConfig
    private var task: Task
    
    init(router: TaskRouter.Routes, config: TaskConfig) {
        self.router = router
        self.config = config
        switch config.mode {
        case .create:
            self.task = Task(id: "33", title: nil, description: nil, date: TaskDate(day: Date(), time: nil))
        case .edit(let task):
            self.task = task
        }
    }
    
    private func updateDateButtonTitle() {
        if let taskDate = task.date {
            view?.setDateButtonTitle(with: taskDate.displayFormate)
        } else {
            view?.setDateButtonTitle(with: R.string.localizable.taskButtonTitleSelectDate())
        }
    }
    
    private func updateSaveButtonTitle() {
        switch config.mode {
        case .create:
            view?.setSaveButtonTitle(with: R.string.localizable.commonCreate())
        case .edit(_):
            view?.setSaveButtonTitle(with: R.string.localizable.commonSave())
        }
    }
}

extension TaskPresenter: TaskOutput {
    func viewIsReady() {
        updateDateButtonTitle()
        updateSaveButtonTitle()
        view?.setTask(task: task)
    }
    
    func didTapSaveButton() {
        switch config.mode {
        case .edit(_):
            config.output.didEditTask(task)
        case .create:
            config.output.didCreateTask(task)
        }
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
