//
//  TaskService.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 21/11/2021.
//

import Foundation
import SwiftyJSON

protocol TaskServiceInput: AnyObject {
    func createTask(task: TaskCreation)
}

protocol TaskServiceOutput: AnyObject {
    func createTaskSucceeded()
    func createTask(didFailWith error: Error)
}

class TaskService {
    
    weak var output: TaskServiceOutput?
    
}

extension TaskService: TaskServiceInput {
    func createTask(task: TaskCreation) {
        
        var dayRaw: String? {
            guard let day = task.taskDate?.day else { return nil }
            return DateFormatter.serverDateFormatter.string(from: day)
        }
        
        var timeRaw: String? {
            guard let day = task.taskDate?.day else { return nil }
            return DateFormatter.serverDateFormatter.string(from: day)
        }
        
        let dateRaw = ["day": dayRaw as Any,
                       "time": timeRaw as Any] as [String : Any]
        
        let dictionary = ["id": task.id ?? UUID().uuidString, "isComplete": task.isComplete as Any,
                          "subtitle": task.subtitle as Any, "title": task.title as Any,
                          "taskDate": dateRaw] as [String : Any]
        
        let json = JSON(dictionary)
        
        StorageHelper.storeObject(from: json) { (result: Result<Task, ApiError>) in
            switch result {
            case .success(_):
                print("success store")
            case .failure(_):
                print("failure store")
            }
        }
    }
}
