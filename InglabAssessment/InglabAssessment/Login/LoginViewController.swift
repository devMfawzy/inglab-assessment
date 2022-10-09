//
//  ViewController.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLoginSuccessfully()
}

class LoginViewController: UIViewController {
    private let mainView = LoginView(title: "Inglab Assessment")
    private var viewModel: LoginViewModel
    weak var delegate: LoginViewControllerDelegate?
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        mainView.onLoginDidTab { [weak self] username, password in
            self?.viewModel.loginWith(username: username, password: password)
        }
        
        viewModel.onSuccess { [weak self] in
            guard let self = self else { return }
            self.mainView.hideLoadingIndicator()
            self.delegate?.didLoginSuccessfully()
        }
        
        viewModel.onError { [weak self] error in
            self?.mainView.showError(message: error)
        }
        
        viewModel.onValidationError { [weak self] error in
            self?.mainView.showError(message: error.description)
        }
        
        viewModel.onLoading { [weak self] in
            self?.mainView.showLoadingIndicator()
        }
    }
}
