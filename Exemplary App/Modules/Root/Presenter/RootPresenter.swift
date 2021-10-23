//
//  RootPresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import Foundation

class RootPresenter {
    private let router: RootRoutes
    
    init(router: RootRoutes) {
        self.router = router
    }
}

extension RootPresenter: RootModuleInput {
    
    func configureNavigationStack() {
        router.openMainModule(animated: false)
    }
}
