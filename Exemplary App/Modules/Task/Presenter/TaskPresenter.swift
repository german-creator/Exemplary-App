//
//  TaskPresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import Foundation

enum TaskModuleMode {
    case create, edit(task: Task), oldTask(task: Task)
}

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
    private let service: TaskService
    
    private var mode: TaskModuleMode
    private var task = TaskCreation()
    
    init(router: TaskRouter.Routes, service: TaskService, mode: TaskModuleMode) {
        self.router = router
        self.service = service
        self.mode = mode
        switch mode {
        case .create: break
        case .edit(let task), .oldTask(let task):
            self.task.set(with: task)
        }
    }
    
    private func updateDateButtonTitle() {
        if let taskDate = task.taskDate {
            view?.setDateButtonTitle(with: taskDate.displayFormate)
        } else {
            view?.setDateButtonTitle(with: R.string.localizable.taskButtonTitleSelectDate())
        }
    }
    
    private func updateSaveButtonTitle() {
        switch mode {
        case .create:
            view?.setSaveButtonTitle(with: R.string.localizable.commonCreate())
        case .edit(_):
            view?.setSaveButtonTitle(with: R.string.localizable.commonSave())
        case .oldTask(_):
            view?.setSaveButtonTitle(with: R.string.localizable.commonActivate())
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
        service.createTask(task: task)
        router.close()
    }
    
    func didTapDateButton() {
        router.openSelectDateModule(config: .init(taskDate: task.taskDate,
                                                  updateTime: { [weak self] taskDate in
            self?.task.taskDate = taskDate
            self?.updateDateButtonTitle()
        }))
    }
    
    func didChangeTitle(_ text: String?) {
        task.title = text
    }
    
    func didChaneDescription(_ text: String?) {
        task.subtitle = text
    }
}
