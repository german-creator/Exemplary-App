//
//  CreateTaskRouter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import Foundation

protocol CreateTaskRoute: BottomContainerRoute {
    func openCreateTaskModule(animated: Bool)
}

extension CreateTaskRoute where Self: RouterProtocol {
    func openCreateTaskModule(animated: Bool) {
        let container = getBottomContainer()
        
        let result = container { transaction in
            CreateTaskModule(transition: transaction).viewController
        }
        open(result.viewController, transition: result.transition)
    }
}

class CreateTaskRouter: Router<CreateTaskViewController>, CreateTaskRouter.Routes {
    typealias Routes = Closable
}
