//
//  CompletedTasksModule.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 20/11/2021.
//

import Foundation

class CompletedTasksModule {
    
    let router: CompletedTasksRouter
    let viewController: CompletedTasksViewController
    
    private let presenter: CompletedTasksPresenter
    
    init(transition: Transition) {

        let router = CompletedTasksRouter()
        let service = MainService(isCompleteTasks: true)
        let presenter = CompletedTasksPresenter(router: router, service: service)
        let viewController = CompletedTasksViewController()

        viewController.output = presenter
        presenter.view = viewController
        router.viewController = viewController
        router.openTransition = transition
        
        self.router = router
        self.viewController = viewController
        self.presenter = presenter
    }
}
