//
//  CompletedTasksViewController.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 20/11/2021.
//

import UIKit
import SnapKit

protocol CompletedTasksViewInput: AnyObject {
    func reloadData()
}

class CompletedTasksViewController: UIViewController {
    
    var output: CompletedTasksViewOutput!
    
    private let taskTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayout()
        
        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeToLeft(_:)))
        swipeGestureRecognizerDown.direction = .right
        view.addGestureRecognizer(swipeGestureRecognizerDown)
        
        output.viewIsReady()
    }
    
    @objc
    private func didSwipeToLeft(_ sender: UISwipeGestureRecognizer){
        output.didSwipeToRight()
    }
    
    private func setupViews() {
        view.backgroundColor = Theme.currentTheme.color.white
        
        navigationItem.title = R.string.localizable.completedTasksTitle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: R.string.localizable.commonClear(),
            style: .plain,
            target: self,
            action: #selector(didTapClearButton))
        
        taskTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        taskTableView.rowHeight = TaskTableViewCell.height
        taskTableView.estimatedRowHeight = TaskTableViewCell.estimatedHeight
        taskTableView.showsVerticalScrollIndicator = false
        taskTableView.alwaysBounceVertical = true
        taskTableView.dataSource = self
        taskTableView.delegate = self
        
        output.viewIsReady()
    }
    
    private func setupLayout() {
        view.addSubview(taskTableView)

        taskTableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
        }
    }
    
    @objc
    private func didTapClearButton(){
        output.didTapClearButton()
    }
}

extension CompletedTasksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfViewModels(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? TaskTableViewCell
        cell?.viewModel = output.viewModel(at: indexPath)
        return cell ?? UITableViewCell()
    }
}

extension CompletedTasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, _ in
            self?.output.didTapDeleteCell(at: indexPath)
        }
        
        action.image = R.image.button_delete()?.withSize(width: 30, height: 30)
        action.backgroundColor = Theme.currentTheme.color.secondRedLight
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didTapCell(at: indexPath)
    }
}

extension CompletedTasksViewController: CompletedTasksViewInput {
    func reloadData() {
        taskTableView.reloadData()
    }
}

