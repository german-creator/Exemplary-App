//
//  BottomContainerPresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import UIKit

protocol BottomContainerOutput {
    func viewIsReady()
    func didTapOutsideContainer()
}

class BottomContainerPresenter {
    
    var view: BottomContainerInput?
    
    private let router: BottomContainerRouter.Routes
    private let contentViewController: UIViewController?

    init(router: BottomContainerRouter.Routes, contentViewController: UIViewController?) {
        self.router = router
        self.contentViewController = contentViewController
    }
}

extension BottomContainerPresenter: BottomContainerOutput {
    func viewIsReady() {
        if let contentViewController = contentViewController {
            view?.setupContainer(with: contentViewController)
        }
    }
    
    func didTapOutsideContainer() {
        router.close()
    }
}
