//
//  ButtonBar.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 28/10/2021.
//

import UIKit

class TwoButtonBar: UIStackView {
    
    private (set) var leftButton = UIButton(type: .system)
    private (set) var rightButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        backgroundColor = Theme.currentTheme.color.white
        
        addArrangedSubview(leftButton)
        addArrangedSubview(rightButton)
        
        spacing = 40
        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        
        layoutMargins = UIEdgeInsets(
            top: Constants.smallMargin,
            left: Constants.smallMargin,
            bottom: Constants.smallMargin,
            right: Constants.smallMargin)
        
        isLayoutMarginsRelativeArrangement = true

        leftButton.setTitleColor(Theme.currentTheme.color.mainAccent, for: .normal)
        leftButton.layer.cornerRadius = Constants.buttonCornerRadius
        leftButton.layer.borderWidth = 2
        leftButton.layer.borderColor = Theme.currentTheme.color.mainAccent.cgColor
        leftButton.bonMotStyle = Theme.currentTheme.stringStyle.h2_17_r
        
        rightButton.setTitleColor(Theme.currentTheme.color.white, for: .normal)
        rightButton.backgroundColor = Theme.currentTheme.color.mainAccent
        rightButton.layer.cornerRadius = Constants.buttonCornerRadius
        rightButton.bonMotStyle = Theme.currentTheme.stringStyle.h2_17_r
    }
    
    private func setupLayout() {
        snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
}
