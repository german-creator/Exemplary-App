//
//  TaskConfig.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18/11/2021.
//

import Foundation

protocol TaskModuleOutput: AnyObject {
    func didCreateTask(_ task: Task)
    func didEditTask(_ task: Task)
}

struct TaskConfig {
    let mode: Mode
    let output: TaskModuleOutput
    
    enum Mode {
        case create, edit(task: Task)
    }
}
