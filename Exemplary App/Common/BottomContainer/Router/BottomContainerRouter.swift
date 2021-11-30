//
//  BottomContainerRouter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import UIKit

typealias BottomContainer = ((Transition) -> UIViewController) -> (viewController: UIViewController,
                                                                   transition: Transition)

protocol BottomContainerRoute {
    func getBottomContainer() -> BottomContainer
}

extension BottomContainerRoute where Self: RouterProtocol {
    func getBottomContainer() -> BottomContainer {
        return { content in
            let transition = ModalTransition()
            transition.modalPresentationStyle = .overCurrentContext
            let contentViewController = content(transition)
            let module = BottomContainerModule(transition: transition,
                                               contentViewController: contentViewController)
            return (module.viewController, transition)
        }
    }
}

class BottomContainerRouter: Router<BottomContainerViewController>, BottomContainerRouter.Routes {
    typealias Routes = Closable
}
