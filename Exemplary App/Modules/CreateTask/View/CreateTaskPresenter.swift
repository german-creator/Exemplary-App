//
//  CreateTaskPresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import Foundation

protocol CreateTaskOutput {
}

class CreateTaskPresenter {
    
    weak var view: CreateTaskInput?
    
    private let router: CreateTaskRouter.Routes
    
    init(router: CreateTaskRouter.Routes) {
        self.router = router
    }
    
}

extension CreateTaskPresenter: CreateTaskOutput {

}
