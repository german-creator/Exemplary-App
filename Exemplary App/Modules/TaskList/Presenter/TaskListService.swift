//
//  TaskListService.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 28/11/2021.
//

import Foundation
import CoreStore

protocol TaskListServiceInput {
    var monitor: ListMonitor<Task> { get }
    var taskCount: Int { get }
    func viewModel(at indexPath: IndexPath) -> Task
    func removeTask(at indexPath: IndexPath)
    func setTaskCompleted(at indexPath: IndexPath)
    func removeCompletedTasks()
}

protocol TaskListServiceOutput: AnyObject {
    func removeTask(didFailWith error: CommonError)
    func setTaskCompleted(didFailWith error: CommonError)
    func removeCompletedTasks(didFailWith error: CommonError)
}

final class TaskListService {
    
    var mode: TaskListMode
    let monitor: ListMonitor<Task>
    weak var output: TaskListServiceOutput?
    
    init(mode: TaskListMode) {
        self.mode = mode
        self.monitor = CoreStoreDefaults.dataStack.monitorList(
            From<Task>().orderBy(.ascending(\.title)).where(\.isComplete == (mode == .complitedTasks)))
    }
}

extension TaskListService: TaskListServiceInput {
    var taskCount: Int {
        monitor.numberOfObjects()
    }
    
    func viewModel(at indexPath: IndexPath) -> Task {
        monitor[indexPath]
    }
    
    func removeTask(at indexPath: IndexPath) {
        guard let id = monitor[indexPath].id else { return }
        
        StorageHelper.removeObject(type: Task.self, id: id) { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                self.output?.removeTask(didFailWith: error)
            }
        }
    }
    
    func setTaskCompleted(at indexPath: IndexPath) {
        StorageHelper.updateTaskComplete(task: monitor[indexPath], newValue: true) { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                self.output?.setTaskCompleted(didFailWith: error)
            }
        }
    }
    
    func removeCompletedTasks() {
        StorageHelper.removeCompletedTasks { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                self.output?.removeCompletedTasks(didFailWith: error)
            }
        }
    }
}
