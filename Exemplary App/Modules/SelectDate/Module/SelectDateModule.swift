//
//  SelectDateModule.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 28/10/2021.
//

import Foundation

struct SelectDateModuleConfig {
    var taskDate: TaskCreation.TaskDateCreation?
    var updateTimeHandler: TaskDateHandler
}

class SelectDateModule {
    
    let router: SelectDateRouter
    let viewController: SelectDateViewController
    
    private let presenter: SelectDatePresenter
    
    init(transition: Transition, config: SelectDateModuleConfig) {

        let router = SelectDateRouter()
        let presenter = SelectDatePresenter(router: router, config: config)
        let viewController = SelectDateViewController()

        viewController.output = presenter
        presenter.view = viewController
        router.viewController = viewController
        router.openTransition = transition
        
        self.router = router
        self.viewController = viewController
        self.presenter = presenter
    }
}
