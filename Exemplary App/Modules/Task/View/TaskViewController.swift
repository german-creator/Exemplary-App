//
//  TaskViewController.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 18.10.2021.
//

import UIKit

protocol TaskInput: AnyObject {
    func setTask(task: TaskCreation?)
    func setDateButtonTitle(with text: String?)
    func setSaveButtonTitle(with text: String?)
}

class TaskViewController: UIViewController {
    
    var output: TaskOutput!
    
    var titleTextField = UITextField()
    var descriptionTextView = InputTextView()
    var toolbar = TwoButtonBar()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setupViews()
        setupLayout()
        
        output.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    private func setupViews(){
        view.backgroundColor = Theme.currentTheme.color.white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        titleTextField.bonMotStyle = Theme.currentTheme.stringStyle.h2_17_r.byAdding(
            .color(Theme.currentTheme.color.black)
        )
        
        titleTextField.attributedPlaceholder =  NSAttributedString(
            string: R.string.localizable.taskTitlePlaceholder(),
            attributes: [NSAttributedString.Key.foregroundColor: Theme.currentTheme.color.grey]
        )
        
        titleTextField.addTarget(
            self,
            action: #selector(textFieldDidChange),
            for: .editingChanged)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        descriptionTextView.delegate = self
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.bonMotStyle =  Theme.currentTheme.stringStyle.h3_15_r.byAdding(
            .color(Theme.currentTheme.color.black)
        )
        descriptionTextView.placeholder = R.string.localizable.taskDesctiptionPlaceholder()
        
        toolbar.rightButton.styledText = R.string.localizable.commonCreate()
        toolbar.leftButton.styledText = R.string.localizable.commonDate()
        toolbar.rightButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        toolbar.leftButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextView)
        view.addSubview(toolbar)
        
        titleTextField.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(Constants.largeMargin)
            make.trailing.equalToSuperview().offset(-Constants.largeMargin)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.largeMargin)
            make.trailing.equalToSuperview().offset(-Constants.largeMargin)
            make.top.equalTo(titleTextField.snp.bottom).offset(Constants.smallMargin)
            make.bottom.equalTo(toolbar.snp.top)
            make.height.greaterThanOrEqualTo(100)
        }
        
        toolbar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        switch sender {
        case toolbar.leftButton:
            output.didTapDateButton()
        case toolbar.rightButton:
            output.didTapSaveButton()
        default: break
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard textField == titleTextField else { return }
        output.didChangeTitle(textField.text)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            toolbar.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-keyboardSize.height)
            }
        }
    }
}

extension TaskViewController: TaskInput {
    func setTask(task: TaskCreation?) {
        titleTextField.styledText = task?.title
        descriptionTextView.styledText = task?.subtitle
    }
    
    func setDateButtonTitle(with text: String?) {
        toolbar.leftButton.styledText = text
    }
    
    func setSaveButtonTitle(with text: String?) {
        toolbar.rightButton.styledText = text
    }

}

extension TaskViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard textView == descriptionTextView else { return }
        output.didChaneDescription(textView.text)
    }
}
