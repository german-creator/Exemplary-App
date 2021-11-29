//
//  BottomContainerModule.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import UIKit

class BottomContainerModule {
    
    let router: BottomContainerRouter
    let viewController: BottomContainerViewController
    private let presenter: BottomContainerPresenter
        
    init(transition: Transition, contentViewController: UIViewController) {
        
        let viewController = BottomContainerViewController()
        let router = BottomContainerRouter()
        let presenter = BottomContainerPresenter(router: router, contentViewController: contentViewController)
        
        viewController.output = presenter
        presenter.view = viewController
        router.viewController = viewController
        router.openTransition = transition

        self.router = router
        self.viewController = viewController
        self.presenter = presenter
    }
}
