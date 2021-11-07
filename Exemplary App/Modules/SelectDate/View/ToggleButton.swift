//
//  ToggleButton.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 30/10/2021.
//

import UIKit

class ToggleButton: UIButton {
    
    var isChosen: Bool = false {
        didSet {
            updateColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }
    
    private func initSetup() {
        layer.cornerRadius = Constants.buttonCornerRadius
        bonMotStyle = Theme.currentTheme.stringStyle.h2_17_r
    }
    
    override var isHighlighted: Bool {
        didSet {
            titleLabel?.alpha = isHighlighted ? 0.4 : 1
        }
    }
    
    private func updateColor() {
        if isChosen {
            layer.borderWidth = 0
            setTitleColor(Theme.currentTheme.color.white, for: .normal)
            backgroundColor = Theme.currentTheme.color.mainAccent
        } else {
            setTitleColor(Theme.currentTheme.color.mainAccent, for: .normal)
            layer.borderWidth = 2
            layer.borderColor = Theme.currentTheme.color.mainAccent.cgColor
            backgroundColor = Theme.currentTheme.color.white
        }
    }
}
