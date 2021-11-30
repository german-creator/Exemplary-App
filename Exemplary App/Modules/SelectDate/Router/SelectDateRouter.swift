//
//  SelectDateRouter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 28/10/2021.
//

protocol SelectDateRoute: BottomContainerRoute {
    func openSelectDateModule(config: SelectDateModuleConfig)
}

extension SelectDateRoute where Self: RouterProtocol {
    func openSelectDateModule(config: SelectDateModuleConfig) {
        let container = getBottomContainer()
        
        let result = container { transaction in
            let selectDateModule = SelectDateModule(transition: transaction, config: config)
            return selectDateModule.viewController
        }
        open(result.viewController, transition: result.transition)
    }
}

final class SelectDateRouter: Router<SelectDateViewController>, SelectDateRouter.Routes {
    
    typealias Routes = Closable
}
