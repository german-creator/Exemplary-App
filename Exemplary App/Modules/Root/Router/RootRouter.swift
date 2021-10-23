//
//  RootRouter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import UIKit

protocol RootRoutes {
    func openMainModule(animated: Bool)
}

class RootRouter: RootRoutes {
    
    let rootWindow: UIWindow
    
    init(window: UIWindow) {
        rootWindow = window
    }
    
    func openMainModule(animated: Bool) {
        let module = MainModule()
        openModuleViewController(module.viewController, animated: animated)
    }
    
    private func openModuleViewController(_ viewController: UIViewController, animated: Bool) {
        let navigationController = UINavigationController.init(rootViewController: viewController)
        rootWindow.rootViewController = navigationController
    }
}
