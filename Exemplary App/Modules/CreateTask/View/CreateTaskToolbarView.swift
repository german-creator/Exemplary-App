//
//  CreateTaskToolbarView.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 17.10.2021.
//

import UIKit

class CreateTaskToolbarView: UIView {
    
    private var stackView = UIStackView()
    private var dateButton = UIButton()
    private var createButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        backgroundColor = Theme.currentTheme.color.white
        addSubview(stackView)
        stackView.addArrangedSubview(dateButton)
        stackView.addArrangedSubview(createButton)
        
        stackView.axis = .horizontal
        stackView.spacing = 200
        
        setupLayout()
    }
    
    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(Constants.mediumMargin)
            make.right.equalTo(self).offset(-Constants.mediumMargin)
            make.height.equalTo(50)
        }
    }
}
