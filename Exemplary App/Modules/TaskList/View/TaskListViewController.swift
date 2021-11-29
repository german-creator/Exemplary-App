//
//  TaskListViewController.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 28/11/2021.
//

import UIKit
import SnapKit

enum TaskListRightButtonType {
    case add, clear
}

enum CellSwipeType {
    case leading, trailing
}

struct EmptyViewModel {
    var title: String?
    var description: String?
    var image: UIImage?
}

protocol TaskListViewInput: AnyObject {
    func reloadData()
    func setAvalibleCellSwipe(avalible: [CellSwipeType])
    func setTitle(_ text: String)
    func setNavigationRightButton(with type: TaskListRightButtonType)
    func showError(title: String, message: String?)
}

class TaskListViewController: UIViewController {
    
    var output: TaskListViewOutput!
    
    private let tableView = UITableView()
    
    private var avalibleCellSwipe: [CellSwipeType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayout()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRight(_:)))
        
        leftSwipe.direction = .right
        rightSwipe.direction = .left
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        output.viewIsReady()
    }
    
    private func setupViews() {
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        tableView.rowHeight = TaskTableViewCell.height
        tableView.estimatedRowHeight = TaskTableViewCell.estimatedHeight
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = true
        tableView.dataSource = self
        tableView.delegate = self
        
        output.viewIsReady()
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    @objc
    private func didTapNavigationRightButton(){
        output.didTapRightButton()
    }
    
    @objc
    private func didSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        output.didSwipeLeft()
    }
    
    @objc
    private func didSwipeRight(_ sender: UISwipeGestureRecognizer) {
        output.didSwipeRight()
    }
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = output.numberOfViewModels(in: section)
        
        if number == 0 {
            tableView.setEmptyView(viewModel: output.emptyViewMode)
        } else {
            tableView.removeEmptyView()
        }
        
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? TaskTableViewCell
        cell?.viewModel = output.viewModel(at: indexPath)
        return cell ?? UITableViewCell()
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard self.avalibleCellSwipe.contains( .trailing ) else { return nil }
        
        let action = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, _ in
            self?.output.didTapDeleteCell(at: indexPath)
        }
        
        action.image = R.image.button_delete()?.withSize(width: 30, height: 30)
        action.backgroundColor = Theme.currentTheme.color.secondRedLight
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard self.avalibleCellSwipe.contains( .leading ) else { return nil }
        
        let action = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, _ in
            self?.output.didTapDoneCell(at: indexPath)
        }
        
        action.image = R.image.button_check()?.withSize(width: 30, height: 30)
        action.backgroundColor = Theme.currentTheme.color.mainAccentLight
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didTapCell(at: indexPath)
    }
}

extension TaskListViewController: TaskListViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    func setAvalibleCellSwipe(avalible: [CellSwipeType]) {
        avalibleCellSwipe = avalible
    }
    
    func setTitle(_ title: String) {
        navigationItem.title = title
    }
    
    func setNavigationRightButton(with type: TaskListRightButtonType) {
        navigationItem.rightBarButtonItem = {
            switch type {
            case .add:
                return UIBarButtonItem(
                    barButtonSystemItem: .add,
                    target: self,
                    action: #selector(didTapNavigationRightButton))
            case .clear:
                return UIBarButtonItem(
                    title: R.string.localizable.commonClear(),
                    style: .plain,
                    target: self,
                    action: #selector(didTapNavigationRightButton))
            }
        }()
    }
    
    func showError(title: String, message: String?) {
        showErrorAlert(title: title, message: message)
    }
}
