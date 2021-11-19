//
//  UserDefaultsService.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 19/11/2021.
//

import Foundation

final class UserDefaultsServise {
    var taskList: [Task] {
        get {
            return getTaskList()
        }
        set {
            setTaskList(newValue)
        }
    }
    
    private let taskListKey = "tasks"

    private func setTaskList(_ tasks: [Task]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(tasks)

            UserDefaults.standard.set(data, forKey: taskListKey)
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    private func getTaskList() -> [Task] {
        if let data = UserDefaults.standard.data(forKey: taskListKey) {
            do {
                let decoder = JSONDecoder()
                let taskList = try decoder.decode([Task].self, from: data)
                return taskList
            } catch {
                print("Unable to Decode Note (\(error))")
                return []
            }
        } else {
            return []
        }
    }
}
