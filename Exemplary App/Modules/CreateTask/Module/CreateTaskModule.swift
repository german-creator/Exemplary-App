//
//  CreateTaskModule.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import Foundation

class CreateTaskModule {
    
    let router: CreateTaskRouter
    let viewController: CreateTaskViewController
    private let presenter: CreateTaskPresenter
        
    init(transition: Transition) {
        let viewController = CreateTaskViewController()
        let router = CreateTaskRouter()
        let presenter = CreateTaskPresenter(router: router)
        
        viewController.output = presenter
        presenter.view = viewController
        router.viewController = viewController
        router.openTransition = transition

        self.router = router
        self.viewController = viewController
        self.presenter = presenter
    }
}
