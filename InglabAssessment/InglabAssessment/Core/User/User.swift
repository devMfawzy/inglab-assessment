//
//  User.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import Foundation

class User {
    static let shared = User()
    private init() { }
    private let isLoggedInKey = "User_isLoggedInKey"
    
    var isLoggedIn: Bool {
        set {
            UserDefaults.standard.setValue(newValue, forKey: isLoggedInKey)
        }
        get {
            UserDefaults.standard.bool(forKey: isLoggedInKey)
        }
    }
}
