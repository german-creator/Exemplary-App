//
//  Router.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 09.10.2021.
//

import UIKit

protocol Closable: AnyObject {
    func close()
    func close(completion: (() -> Void)?)
}

protocol RouterProtocol: AnyObject {
    associatedtype V: UIViewController
    var viewController: V? { get }
    
    func open(_ viewController: UIViewController, transition: Transition)
    func open(_ viewController: UIViewController, transition: Transition, completion: (() -> Void)?)
}

class Router<U>: RouterProtocol where U: UIViewController {
    typealias V = U

    weak var viewController: V?
    var openTransition: Transition?
        
    func open(_ viewController: UIViewController, transition: Transition) {
        open(viewController, transition: transition, completion: nil)
    }
    
    func open(_ viewController: UIViewController, transition: Transition, completion: (() -> Void)?) {
        transition.sourceViewController = self.viewController
        transition.open(viewController, completion: completion)
    }
    
    func close() {
        close(completion: nil)
    }
    
    func close(completion: (() -> Void)?) {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.close(viewController, completion: completion)
    }
}

