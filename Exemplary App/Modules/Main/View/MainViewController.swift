//
//  MainViewController.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import UIKit
import SnapKit

protocol MainViewInput: AnyObject {
    func reloadData()
}

class MainViewController: UIViewController {
    
    var output: MainViewOutput!
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Today"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem?.tintColor = Theme.currentTheme.color.mainAccent
        
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        tableView.rowHeight = TaskTableViewCell.height
        tableView.estimatedRowHeight = TaskTableViewCell.estimatedHeight
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = true
        tableView.allowsSelection = false
        tableView.dataSource = self
        
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        view.backgroundColor = Theme.currentTheme.color.white
        view.addSubview(tableView)
        
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
        }
    }
    
    @objc
    private func didTapAddButton(){
        output.didTapAddButton()
    }
}

extension MainViewController: UITableViewDataSource {
    
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

extension MainViewController: MainViewInput {
    func reloadData() {
        tableView.reloadData()
    }
}
