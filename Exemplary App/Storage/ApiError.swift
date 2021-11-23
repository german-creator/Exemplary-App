//
//  ApiError.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 22/11/2021.
//

import Foundation
import SwiftyJSON

struct ApiError: Error {
    enum ErrorType {
        case test
    }
    
    let type: ErrorType
    let originalMessage: String?
    let additionalData: JSON?

    init(type: ErrorType, originalMessage: String? = nil, additionalData: JSON? = nil) {
        self.type = type
        self.originalMessage = originalMessage
        self.additionalData = additionalData
    }
}
