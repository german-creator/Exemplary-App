//
//  TaskService.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 21/11/2021.
//

import Foundation

protocol TaskServiceInput: AnyObject {
    func setTask(task: TaskCreation)
}

protocol TaskServiceOutput: AnyObject {
    func setTaskSucceeded()
    func setTask(didFailWith error: CommonError)
}

class TaskService {
    
    weak var output: TaskServiceOutput?
}

extension TaskService: TaskServiceInput {
    func setTask(task: TaskCreation) {
        StorageHelper.storeObject(from: task.dictionary()) { (result: Result<Task, CommonError>) in
            switch result {
            case .success(_):
                self.output?.setTaskSucceeded()
            case let .failure(error):
                self.output?.setTask(didFailWith: error)
            }
        }
    }
}
