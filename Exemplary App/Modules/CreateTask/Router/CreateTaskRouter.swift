//
//  CreateTaskRouter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import Foundation

protocol CreateTaskRoute: BottomContainerRoute {
    func openCreateTaskModule(output: CreateTaskModuleOutput)
}

extension CreateTaskRoute where Self: RouterProtocol {
    func openCreateTaskModule(output: CreateTaskModuleOutput) {
        let container = getBottomContainer()
        
        let result = container { transaction in
            let createTaskModule = CreateTaskModule(transition: transaction)
            createTaskModule.output = output
            return createTaskModule.viewController
        }
        open(result.viewController, transition: result.transition)
    }
}

class CreateTaskRouter: Router<CreateTaskViewController>, CreateTaskRouter.Routes {
    typealias Routes = Closable & SelectDateRoute & BottomContainerRoute
}
