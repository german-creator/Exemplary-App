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
    func configureMainView() {
        router.openTaskListModule(animated: true)
    }
}
