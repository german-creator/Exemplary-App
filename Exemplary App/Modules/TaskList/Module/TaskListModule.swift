//
//  TaskListModule.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 28/11/2021.
//

import Foundation

enum TaskListMode {
    case currentTasks, complitedTasks
}

class TaskListModule {
    
    let router: TaskListRouter
    let viewController: TaskListViewController
    
    private let presenter: TaskListPresenter
    
    init(transition: Transition?, mode: TaskListMode) {

        let router = TaskListRouter()
        let service = TaskListService(mode: mode)
        let presenter = TaskListPresenter(router: router, service: service, mode: mode)
        let viewController = TaskListViewController()

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

