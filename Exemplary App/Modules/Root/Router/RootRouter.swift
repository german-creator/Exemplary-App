//
//  RootRouter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import UIKit

protocol RootRoutes {
    func openTaskListModule(animated: Bool)
}

class RootRouter: RootRoutes {
    
    let rootWindow: UIWindow
    
    init(window: UIWindow) {
        rootWindow = window
    }
    
    func openTaskListModule(animated: Bool) {
        let module = TaskListModule(transition: nil, mode: .currentTasks)
        openModuleViewController(module.viewController, animated: animated)
    }
    
    private func openModuleViewController(_ viewController: UIViewController, animated: Bool) {
        let navigationController = UINavigationController.init(rootViewController: viewController)
        rootWindow.rootViewController = navigationController
    }
}
