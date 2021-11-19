//
//  InputTextView.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 26/10/2021.
//

import UIKit

class InputTextView: UITextView {
    
    var placeholder: String? {
        didSet {
            updatePlaceholderText()
        }
    }
    
    override var text: String? {
        get {
            super.text
        }
        set {
            super.text = newValue
            updatePlaceholderText()
        }
    }
    
    override var attributedText: NSAttributedString! {
        get {
            return super.attributedText
        }
        set {
            super.attributedText = newValue
            updatePlaceholderText()
        }
    }
    
    private (set) var placeholderLabel = UILabel()
        
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSetup()
    }
    
    private func initSetup() {
        // TextField inset imitation
        textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        
        addSubview(placeholderLabel)
        setupLayout()
        
        placeholderLabel.bonMotStyle = Theme.currentTheme.stringStyle.h3_15_r.byAdding(
            .color(Theme.currentTheme.color.grey)
        )
        addObserver()
    }

    private func setupLayout() {
        placeholderLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updatePlaceholderText),
            name: UITextView.textDidChangeNotification,
            object: nil)
    }
    
    @objc private func updatePlaceholderText() {
        placeholderLabel.styledText = text?.isEmpty ?? true ? placeholder : nil
    }
}
