//
//  TaskListRouter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 28/11/2021.
//

protocol TaskListRoute {
    func openTaskListModule(mode: TaskListMode)
}

extension TaskListRoute where Self: RouterProtocol {
    func openTaskListModule(mode: TaskListMode) {
        let transition = PushTransition()
        let module = TaskListModule(transition: transition, mode: mode)
        open(module.viewController, transition: transition)
    }
}

final class TaskListRouter: Router<TaskListViewController>, TaskListRouter.Routes {

    typealias Routes = Closable & TaskListRoute & TaskRoute & BottomContainerRoute
    
}
