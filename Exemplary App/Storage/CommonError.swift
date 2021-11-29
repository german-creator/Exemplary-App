//
//  CommonError.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 22/11/2021.
//

import Foundation

struct CommonError: Error {
    
    enum ErrorType {
        case database
        case parce
    }
    
    let type: ErrorType
    var message: String? {
        switch type {
        case .database, .parce:
           return R.string.localizable.commonErrorMessage()
        }
    }

    init(type: ErrorType, message: String? = nil) {
        self.type = type
    }
}
