//
//  CreateTaskViewController.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import UIKit

protocol CreateTaskInput: AnyObject {

}

class CreateTaskViewController: UIViewController {
    
    var output: CreateTaskOutput!
    
    var titleTextField = UITextField()
    var desciptionTextView = UITextView()
    var toolbar = CreateTaskToolbarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        view.backgroundColor = Theme.currentTheme.color.white
        
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        view.addSubview(titleTextField)
        view.addSubview(desciptionTextView)
        view.addSubview(toolbar)        
    }
    
    private func setupLayout() {
        titleTextField.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
        }
    }
}

extension CreateTaskViewController: CreateTaskInput {

}
