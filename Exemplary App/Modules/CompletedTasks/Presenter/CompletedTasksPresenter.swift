//
//  CompletedTasksPresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 20/11/2021.
//

import Foundation
import CoreStore

protocol CompletedTasksViewOutput {
    func viewIsReady()
    func didTapClearButton()
    func didTapCell(at indexPath: IndexPath)
    func didTapDeleteCell(at indexPath: IndexPath)
    func didSwipeToRight()
    func numberOfSections() -> Int
    func numberOfViewModels(in section: Int) -> Int
    func viewModel(at indexPath: IndexPath) -> Task
}

class CompletedTasksPresenter {
    
    weak var view: CompletedTasksViewInput?
    
    private let router: CompletedTasksRouter.Routes
    private let service: MainService
        
    init(router: CompletedTasksRouter.Routes, service: MainService) {
        self.router = router
        self.service = service
    }
}

extension CompletedTasksPresenter: CompletedTasksViewOutput {
    func viewIsReady() {
        service.monitor.addObserver(self)
        view?.reloadData()
    }

    func didTapClearButton() {
    }
    
    func didTapCell(at indexPath: IndexPath) {
        router.openCreateTaskModule(mode: .oldTask(task: service.viewModel(at: indexPath)))
    }
    
    func didTapDeleteCell(at indexPath: IndexPath) {
        service.removeTask(at: indexPath)
    }

    func didSwipeToRight() {
        router.close()
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfViewModels(in section: Int) -> Int {
        service.taskCount
    }
    
    func viewModel(at indexPath: IndexPath) -> Task {
        service.viewModel(at: indexPath)
    }
}

extension CompletedTasksPresenter: ListObserver {
    typealias ListEntityType = Task

    func listMonitorDidChange(_ monitor: ListMonitor<Task>) {
        view?.reloadData()
    }
    
    func listMonitorDidRefetch(_ monitor: ListMonitor<Task>) {
        view?.reloadData()
    }
}
