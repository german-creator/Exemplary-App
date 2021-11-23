//
//  MainRouter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import UIKit

protocol MainRoute {
}

extension MainRoute where Self: RouterProtocol {
}

class MainRouter: Router<MainViewController>, MainRouter.Routes {
    
    typealias Routes = Closable & TaskRoute & BottomContainerRoute & CompletedTasksRoute
    
}
