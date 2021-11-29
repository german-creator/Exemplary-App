//
//  UIViewController.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29/11/2021.
//

import UIKit

extension UIViewController {
    
    typealias DatePickerHandler = (Date?) -> Void
    
    func showDatePickerAlert(date: Date?, complition: @escaping DatePickerHandler) {
        
        let alertView = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertView.view.tintColor = Theme.currentTheme.color.mainAccent
        
        let datePicker: UIDatePicker = UIDatePicker()
        
        datePicker.timeZone = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        
        if let date = date {
            datePicker.setDate(date, animated: false)
        }
        
        let cancelActionTitle = date != nil ?
        R.string.localizable.commonRemove() :
        R.string.localizable.commonCancel()
        
        let cancelAction = UIAlertAction(
            title: cancelActionTitle,
            style: .default) { _ in
                if date != nil {
                    complition(nil)
                }
            }
        
        let okAction = UIAlertAction(
            title: R.string.localizable.commonOk(),
            style: .default) { _ in
                complition(datePicker.date)
            }
        
        alertView.view.addSubview(datePicker)
        alertView.addAction(cancelAction)
        alertView.addAction(okAction)
        
        datePicker.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        
        alertView.view.snp.makeConstraints { make in
            make.height.equalTo(280)
        }
        
        present(alertView, animated: true)
    }
    
    func showErrorAlert(title: String, message: String?) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertView.addAction(
            UIAlertAction(title: R.string.localizable.commonOk(),
                          style: .cancel, handler: { _ in
                              alertView.dismiss(animated: true, completion: nil)
                          }))
        present(alertView, animated: true)
    }
}
