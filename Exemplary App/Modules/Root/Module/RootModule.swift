//
//  RootModule.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import UIKit

protocol RootModuleInput: AnyObject {
    func configureNavigationStack()
}

class RootModule {
        
    private let router: RootRouter
    private let presenter: RootPresenter

    var input: RootModuleInput {
        return presenter
    }
    
    var rootWindow: UIWindow {
        return router.rootWindow
    }
    
    init(window: UIWindow) {
        window.overrideUserInterfaceStyle = Theme.currentTheme.userInterfaceStyle
        router = RootRouter(window: window)
        presenter = RootPresenter(router: router)
    }
}
