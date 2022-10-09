//
//  LoginCoordinator.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func switchRootViewController()
}

class LoginCoordinator: Coordinator {
    let window: UIWindow
    weak var delegate: LoginCoordinatorDelegate?
    
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        viewController.delegate = self
        changeRootViewController(viewController, window: window)
    }
}


extension LoginCoordinator: LoginViewControllerDelegate {
    func didLoginSuccessfully() {
        User.shared.isLoggedIn = true
        delegate?.switchRootViewController()
    }
}

