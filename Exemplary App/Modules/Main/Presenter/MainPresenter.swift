//
//  MainPresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import Foundation

protocol MainViewOutput {
    func viewIsReady()
    func viewDidDisappear()
    func didTapAddButton()
    func didTapCell(at indexPath: IndexPath)
    func didTapDeleteCell(at indexPath: IndexPath)
    func didTapDoneCell(at indexPath: IndexPath)
    func numberOfSections() -> Int
    func numberOfViewModels(in section: Int) -> Int
    func viewModel(at indexPath: IndexPath) -> Task
}

class MainPresenter {
    weak var view: MainViewInput?
    
    private let router: MainRouter.Routes
    private let service: UserDefaultsServise
    
    private var taskList: [Task] = []
    
    init(router: MainRouter.Routes, service: UserDefaultsServise) {
        self.router = router
        self.service = service
    }
}

extension MainPresenter: MainViewOutput {
    func viewIsReady() {
        taskList = service.taskList
        view?.reloadData()
    }
    
    func viewDidDisappear() {
        service.taskList = taskList
    }
    
    func didTapAddButton() {
        router.openCreateTaskModule(config: .init(mode: .create, output: self))
    }
    
    func didTapCell(at indexPath: IndexPath) {
        router.openCreateTaskModule(config: .init(mode: .edit(task: taskList[indexPath.row]), output: self))
    }

    
    func didTapDeleteCell(at indexPath: IndexPath) {
        
    }

    func didTapDoneCell(at indexPath: IndexPath) {
        taskList.remove(at: indexPath.row)
        view?.reloadData()
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfViewModels(in section: Int) -> Int {
        taskList.count
    }
    
    func viewModel(at indexPath: IndexPath) -> Task {
        return taskList[indexPath.row]
    }
}

extension MainPresenter: TaskModuleOutput {
    func didCreateTask(_ task: Task) {
        taskList.append(task)
        view?.reloadData()
    }
    
    func didEditTask(_ task: Task) {
        if let index = taskList.firstIndex(where: { $0.id == task.id }) {
            taskList[index] = task
            view?.reloadData()
        }
    }
}
