//
//  LoginServiceProtocol.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import Foundation

enum LoginResult {
    case sucsess
    case error(String)
}

protocol LoginServiceProtocol {
    func login(username: String, password: String, completion: @escaping (LoginResult)->Void)
}

class LoginService: LoginServiceProtocol {
    func login(username: String, password: String, completion: @escaping (LoginResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            if username == password {
                completion(.sucsess)
            } else {
                completion(.error("Invalid username or password"))
            }
        }
    }
}
