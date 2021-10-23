//
//  MainPresenter.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import Foundation

protocol MainViewOutput {
    func didTapAddButton()
    func didCreateNewTask(with title: String)
    func numberOfSections() -> Int
    func numberOfViewModels(in section: Int) -> Int
    func viewModel(at indexPath: IndexPath) -> TaskViewModel
}

class MainPresenter {
    weak var view: MainViewInput?
    
    private let router: MainRouter.Routes
    
    private var tasksArray: [TaskViewModel] = [
        .init(status: .base, title: "First item", date: Date(), addInfo: false),
        .init(status: .overdue, title: "Second item", date: Date(), addInfo: true)
        
    ]
    
    init(router: MainRouter.Routes) {
        self.router = router
    }
}

extension MainPresenter: MainViewOutput {
    func didTapAddButton() {
        router.openCreateTaskModule(animated: true)
    }
    
    func didCreateNewTask(with title: String) {
        tasksArray.insert(TaskViewModel(
            status: .base,
            title: title,
            date: Date(),
            addInfo: false),
                          at: 0)
        view?.reloadData()
    }
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfViewModels(in section: Int) -> Int {
        tasksArray.count
    }
    
    func viewModel(at indexPath: IndexPath) -> TaskViewModel {
        return tasksArray[indexPath.row]
    }
}
