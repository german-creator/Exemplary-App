//
//  MainService.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 22/11/2021.
//

import Foundation
import CoreStore

protocol MainServiceInput {
    var monitor: ListMonitor<Task> { get }
    var taskCount: Int { get }
    func viewModel(at indexPath: IndexPath) -> Task
    func removeTask(at indexPath: IndexPath)
    func updateTask(at indexPath: IndexPath)
}

final class MainService {
    
    var isCompleteTasks: Bool
    let monitor: ListMonitor<Task>

    init(isCompleteTasks: Bool) {
        self.isCompleteTasks = isCompleteTasks
        self.monitor = CoreStoreDefaults.dataStack.monitorList(
            From<Task>().orderBy(.ascending(\.title)).where(\.isComplete == isCompleteTasks))
    }

}

extension MainService: MainServiceInput {
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
                print("remove succeed")
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func updateTask(at indexPath: IndexPath) {
        
    }
}
