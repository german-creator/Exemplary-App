//
//  MainPresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import Foundation

protocol MainViewOutput {
    func didTapAddButton()
    func numberOfSections() -> Int
    func numberOfViewModels(in section: Int) -> Int
    func viewModel(at indexPath: IndexPath) -> Task
}

class MainPresenter {
    weak var view: MainViewInput?
    
    private let router: MainRouter.Routes
    
    private var tasksArray: [Task] = [
        .init(title: "Work", description: nil, date: .init(), status: .base),
        .init(title: "Eat", description: nil, date: .init(), status: .overdue)
        
    ]
    
    init(router: MainRouter.Routes) {
        self.router = router
    }
}

extension MainPresenter: MainViewOutput {
    func didTapAddButton() {
        router.openCreateTaskModule(output: self)
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfViewModels(in section: Int) -> Int {
        tasksArray.count
    }
    
    func viewModel(at indexPath: IndexPath) -> Task {
        return tasksArray[indexPath.row]
    }
}

extension MainPresenter: CreateTaskModuleOutput {
    func didCreateTask(_ task: Task) {
        tasksArray.append(task)
        view?.reloadData()
    }
}
