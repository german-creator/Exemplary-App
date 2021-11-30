//
//  TaskStorageHelper.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 30/11/2021.
//

import Foundation
import CoreStore

enum TaskStorageHelper {
    static func removeCompletedTasks(completion: ((Result<Void, CommonError>) -> Void)? = nil) {
        
        CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> Void in
            try transaction.deleteAll(From<Task>().where(\.isComplete == true))
        }, success: { _ in
            completion?(.success(()))
        }, failure: { _ in
            completion?(.failure(CommonError(type: .database)))
        })
    }
    
    static func updateTaskComplete(task: Task,
                                   newValue: Bool,
                                   completion: ((Result<Void, CommonError>) -> Void)? = nil) {
            
            CoreStoreDefaults.dataStack.perform(asynchronous: { transaction -> Void in
                let editedObject = transaction.edit(task)
                editedObject?.isComplete = true
            }, success: { _ in
                completion?(.success(()))
            }, failure: { _ in
                completion?(.failure(CommonError(type: .database)))
            })
        }
}
