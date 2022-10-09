//
//  LoginViewModel.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import Foundation

protocol LoginViewModeling {
    func loginWith(username: String, password: String)
    func onSuccess(handler: @escaping () -> Void)
    func onError(handler: @escaping (_ error:  String) -> Void)
    func onValidationError(handler: @escaping (_ error: LoginValidationError) -> Void)
    func onLoading(handler: @escaping () -> Void)
}

class LoginViewModel: LoginViewModeling {
    private var service: LoginServiceProtocol
    private var loginValidator: LoginValidatorProtocl
    
    private var loginSuccessHandler: (() -> Void)?
    private var loginErrorHandler: ((String) -> Void)?
    private var validationErrorHandler: ((LoginValidationError) -> Void)?
    private var loadingHandler: (() -> Void)?
    
    init(service: LoginServiceProtocol = LoginService(), validator: LoginValidatorProtocl = LoginValidator()) {
        self.service = service
        self.loginValidator = validator
    }
    
    //MARK: Actions
    func loginWith(username: String, password: String) {
        if let validationError = loginValidator.validate(username: username, password: password) {
            validationErrorHandler?(validationError)
        } else {
            loadingHandler?()
            service.login(username: username, password: password) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .sucsess:
                    self.loginSuccessHandler?()
                case .error(let error):
                    self.loginErrorHandler?(error)
                }
            }
        }
    }
    
    //MARK: Events
    func onValidationError(handler: @escaping (LoginValidationError) -> Void) {
        validationErrorHandler = handler
    }
    
    func onLoading(handler: @escaping () -> Void) {
        loadingHandler = handler
    }
    
    func onSuccess(handler: @escaping () -> Void) {
        loginSuccessHandler = handler
    }
    
    func onError(handler: @escaping (String) -> Void) {
        loginErrorHandler = handler
    }
}

