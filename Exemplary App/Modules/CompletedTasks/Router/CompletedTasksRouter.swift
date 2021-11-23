//
//  CompletedTasksRouter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 20/11/2021.
//

protocol CompletedTasksRoute {
    func openCompletedTasksModule()
}

extension CompletedTasksRoute where Self: RouterProtocol {
    func openCompletedTasksModule() {
        let transition = PushTransition()
        let module = CompletedTasksModule(transition: transition)
        open(module.viewController, transition: transition)
    }
}

class CompletedTasksRouter: Router<CompletedTasksViewController>, CompletedTasksRouter.Routes {

    typealias Routes = Closable & TaskRoute & BottomContainerRoute
}
