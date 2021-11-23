//
//  TaskRouter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import Foundation

protocol TaskRoute: BottomContainerRoute {
    func openCreateTaskModule(mode: TaskModuleMode)
}

extension TaskRoute where Self: RouterProtocol {
    func openCreateTaskModule(mode: TaskModuleMode) {
        let container = getBottomContainer()
        
        let result = container { transaction in
            let createTaskModule = TaskModule(transition: transaction, mode: mode)
            return createTaskModule.viewController
        }
        open(result.viewController, transition: result.transition)
    }
}

class TaskRouter: Router<TaskViewController>, TaskRouter.Routes {
    typealias Routes = Closable & SelectDateRoute & BottomContainerRoute
}
