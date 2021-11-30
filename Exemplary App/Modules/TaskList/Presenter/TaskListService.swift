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
    func setTaskIsComplete(isComplete: Bool, at indexPath: IndexPath)
    func removeCompletedTasks()
}

protocol TaskListServiceOutput: AnyObject {
    func removeTask(didFailWith error: CommonError)
    func setTaskComplete(didFailWith error: CommonError)
    func removeCompletedTasks(didFailWith error: CommonError)
}

final class TaskListService {
    
    var mode: TaskListMode
    let monitor: ListMonitor<Task>
    weak var output: TaskListServiceOutput?
    
    let taskOrder = OrderBy<Task>(.ascending(\.taskDate?.day))
    
    init(mode: TaskListMode) {
        self.mode = mode
        self.monitor = CoreStoreDefaults.dataStack.monitorList(
            From<Task>().orderBy(taskOrder).where(\.isComplete == (mode == .complitedTasks)))
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
        guard let taskId = monitor[indexPath].id else { return }
        
        StorageHelper.removeObject(type: Task.self, objectId: taskId) { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                self.output?.removeTask(didFailWith: error)
            }
        }
    }
    
    func setTaskIsComplete(isComplete: Bool, at indexPath: IndexPath) {
        TaskStorageHelper.updateTaskComplete(task: monitor[indexPath], newValue: isComplete) { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                self.output?.setTaskComplete(didFailWith: error)
            }
        }
    }
    
    func removeCompletedTasks() {
        TaskStorageHelper.removeCompletedTasks { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                self.output?.removeCompletedTasks(didFailWith: error)
            }
        }
    }
}
