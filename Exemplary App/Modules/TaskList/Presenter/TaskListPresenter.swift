//
//  TaskListPresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 28/11/2021.
//

import Foundation
import CoreStore

protocol TaskListViewOutput {
    var emptyViewMode: EmptyViewModel { get }
    func viewIsReady()
    func didTapRightButton()
    func didTapCell(at indexPath: IndexPath)
    func didTapDeleteCell(at indexPath: IndexPath)
    func didTapDoneCell(at indexPath: IndexPath)
    func didSwipeLeft()
    func didSwipeRight()
    func numberOfViewModels(in section: Int) -> Int
    func viewModel(at indexPath: IndexPath) -> Task
}

final class TaskListPresenter {
    
    weak var view: TaskListViewInput?
    
    private let router: TaskListRouter.Routes
    private let service: TaskListService
    private let mode: TaskListMode
    
    init(router: TaskListRouter.Routes, service: TaskListService, mode: TaskListMode) {
        self.router = router
        self.service = service
        self.mode = mode
    }
}

extension TaskListPresenter: TaskListViewOutput {
    var emptyViewMode: EmptyViewModel {
        switch mode {
        case .complitedTasks:
            return EmptyViewModel(
                title: R.string.localizable.taskListCompletedTasksEmptyViewTitle(),
                description: R.string.localizable.taskListCompletedTasksEmptyViewDescription(),
                image: R.image.empty_folder())
        case .currentTasks:
            return EmptyViewModel(
                title: R.string.localizable.taskListCurrentTasksEmptyViewTitle(),
                description: R.string.localizable.taskListCurrentTasksDescription(),
                image: R.image.empty_list())
        }
    }
    
    func viewIsReady() {
        switch mode {
        case .currentTasks:
            view?.setTitle(R.string.localizable.taskListCurrentTasksTitle())
            view?.setNavigationRightButton(with: .add)
            view?.setAvalibleCellSwipe(avalible: [.trailing, .leading])
        case .complitedTasks:
            view?.setTitle(R.string.localizable.taskListCompletedTasksTitle())
            view?.setNavigationRightButton(with: .clear)
            view?.setAvalibleCellSwipe(avalible: [.trailing])
        }
        
        service.monitor.addObserver(self)
        view?.reloadData()
    }
    
    func didTapDeleteCell(at indexPath: IndexPath) {
        service.removeTask(at: indexPath)
    }
    
    func didTapRightButton() {
        switch mode {
        case .currentTasks:
            router.openCreateTaskModule(mode: .create)
        case .complitedTasks:
            service.removeCompletedTasks()
        }
    }
    
    func didSwipeLeft() {
        guard mode == .complitedTasks else { return }
        router.close()
    }
    
    func didSwipeRight() {
        guard mode == .currentTasks else { return }
        router.openTaskListModule(mode: .complitedTasks)
    }
    
    func didTapCell(at indexPath: IndexPath) {
        var createTaskMode: TaskModuleMode {
            switch mode {
            case .complitedTasks:
                return .complitedTask(task: service.viewModel(at: indexPath))
            case .currentTasks:
                return .edit(task: service.viewModel(at: indexPath))
            }
        }
        router.openCreateTaskModule(mode: createTaskMode)
    }
    
    func didTapDoneCell(at indexPath: IndexPath) {
        service.setTaskIsComplete(isComplete: true, at: indexPath)
    }
    
    func numberOfViewModels(in section: Int) -> Int {
        service.taskCount
    }
    
    func viewModel(at indexPath: IndexPath) -> Task {
        service.viewModel(at: indexPath)
    }
}

extension TaskListPresenter: ListObserver {
    typealias ListEntityType = Task
    
    func listMonitorDidChange(_ monitor: ListMonitor<Task>) {
        view?.reloadData()
    }
    
    func listMonitorDidRefetch(_ monitor: ListMonitor<Task>) {
        view?.reloadData()
    }
}

extension TaskListPresenter: TaskListServiceOutput {
    func removeTask(didFailWith error: CommonError) {
        view?.showError(title: R.string.localizable.commonOk(), message: error.message)
    }
    
    func setTaskComplete(didFailWith error: CommonError) {
        view?.showError(title: R.string.localizable.commonOk(), message: error.message)
    }
    
    func removeCompletedTasks(didFailWith error: CommonError) {
        view?.showError(title: R.string.localizable.commonOk(), message: error.message)
    }
}
