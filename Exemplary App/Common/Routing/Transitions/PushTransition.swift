//
//  PushTransition.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 09.10.2021.
//

import UIKit

final class PushTransition: NSObject {
    
    var animator: Animator?
    var isAnimated: Bool = true
    var completionHandler: (() -> Void)?
    
    weak var sourceViewController: UIViewController?
    
    init(animator: Animator? = nil, isAnimated: Bool = true) {
        self.animator = animator
        self.isAnimated = isAnimated
    }
}

extension PushTransition: Transition {
    
    func open(_ viewController: UIViewController, completion: (() -> Void)?) {
        self.sourceViewController?.navigationController?.delegate = self
        self.sourceViewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        self.sourceViewController?.navigationController?.popViewController(animated: isAnimated)
    }
}

extension PushTransition: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        completionHandler?()
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        
        if operation == .push {
            animator.isPresenting = true
            return animator
        } else {
            animator.isPresenting = false
            return animator
        }
    }
}
