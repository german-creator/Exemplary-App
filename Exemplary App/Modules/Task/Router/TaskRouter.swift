//
//  TaskRouter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import Foundation

protocol TaskRoute: BottomContainerRoute {
    func openCreateTaskModule(config: TaskConfig)
}

extension TaskRoute where Self: RouterProtocol {
    func openCreateTaskModule(config: TaskConfig) {
        let container = getBottomContainer()
        
        let result = container { transaction in
            let createTaskModule = TaskModule(transition: transaction, config: config)
            return createTaskModule.viewController
        }
        open(result.viewController, transition: result.transition)
    }
}

class TaskRouter: Router<TaskViewController>, TaskRouter.Routes {
    typealias Routes = Closable & SelectDateRoute & BottomContainerRoute
}
