//
//  LoginValidator.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import Foundation

enum LoginValidationError {
    case missingUsername
    case missingPassword
    case missingUserNameAndPassword
    
    var description: String {
        switch self {
        case .missingUsername:
            return "Please enter valid username"
        case .missingPassword:
            return "Please enter valid password"
        case .missingUserNameAndPassword:
            return "Username and password are required"
        }
    }
}

class LoginValidator {
    func validate(username: String, password: String) -> LoginValidationError? {
        var result: LoginValidationError?
        if username.isEmpty {
            result = .missingUsername
        }
        if password.isEmpty {
            result = result == .missingUsername ? .missingUserNameAndPassword : .missingPassword
        }
        return result
    }
}
