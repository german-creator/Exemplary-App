//
//  MainModule.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import Foundation

class MainModule {
    
    let router: MainRouter
    let viewController: MainViewController
    private let presenter: MainPresenter

        
    init() {
        let viewController = MainViewController()
        let router = MainRouter()
        let presenter = MainPresenter(router: router)
        
        viewController.output = presenter
        presenter.view = viewController
        router.viewController = viewController

        self.router = router
        self.viewController = viewController
        self.presenter = presenter
    }
}
