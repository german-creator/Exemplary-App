//
//  TaskModule.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import Foundation

class TaskModule {
    
    let router: TaskRouter
    let viewController: TaskViewController
    private let presenter: TaskPresenter
        
    init(transition: Transition, config: TaskConfig) {
        let viewController = TaskViewController()
        let router = TaskRouter()
        let presenter = TaskPresenter(router: router, config: config)
        
        viewController.output = presenter
        presenter.view = viewController
        router.viewController = viewController
        router.openTransition = transition

        self.router = router
        self.viewController = viewController
        self.presenter = presenter
    }
}
