//
//  CalendarCollectionViewCell.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 31/10/2021.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    private let numberLabel = UILabel()
    
    static let reuseIdentifier = String(describing: self)
    
    var text: String? {
        didSet {
            updateText()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initSetup() {
        layer.cornerRadius = layer.frame.height / 2

        addSubview(numberLabel)
        
        numberLabel.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        numberLabel.bonMotStyle = Theme.currentTheme.stringStyle.h1_20_b.byAdding(
            .color(Theme.currentTheme.color.black),
            .alignment(.center)
        )
    }
    
    func updateText() {
        numberLabel.styledText = text
    }
}
