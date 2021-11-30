//
//  TaskModule.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import Foundation

enum TaskModuleMode {
    case create, edit(task: Task), complitedTask(task: Task)
}

final class TaskModule {
    
    let router: TaskRouter
    let viewController: TaskViewController
    private let presenter: TaskPresenter
        
    init(transition: Transition, mode: TaskModuleMode) {
        let viewController = TaskViewController()
        let router = TaskRouter()
        let service = TaskService()
        let presenter = TaskPresenter(router: router, service: service, mode: mode)
        
        viewController.output = presenter
        presenter.view = viewController
        router.viewController = viewController
        router.openTransition = transition
        service.output = presenter
        
        self.router = router
        self.viewController = viewController
        self.presenter = presenter
    }
}
