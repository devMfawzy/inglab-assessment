//
//  LoginView.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import UIKit
import SnapKit
import KeyboardAvoidingView

class LoginView: UIView {
    //Mark: public properties
    func onLoginDidTab(handler: @escaping (_ userName: String, _ password: String) -> Void) {
        onLoginHandler = handler
    }
    
    func showError(message: String) {
        activityIndicatorView.stopAnimating()
        loginButton.isEnabled = false
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func showLoadingIndicator() {
        activityIndicatorView.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicatorView.stopAnimating()
    }
    
    //MARK: Private properties
    private let imageView = UIImageView()
    private let label = UILabel()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private lazy var toggleVisibiltyButton = UIButton()
    private lazy var userNameContainer = usernameTextField.containerView(leftImageName: "iconUser")
    private lazy var passwordContainer = passwordTextField.containerView(leftImageName: "iconPassword", rightButton: toggleVisibiltyButton)
    private let loginButton = UIButton(type: .system)
    private let errorLabel = UILabel()
    private var onLoginHandler: ((String, String) -> Void)?
    private lazy var activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)

    
    init(title: String) {
        super.init(frame: .zero)
        addSubviews()
        setUpConstraints()
        setUpViews(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(imageView)
        let keyboardAvoidingView = KeyboardAvoidingView()
        keyboardAvoidingView.translatesAutoresizingMaskIntoConstraints = true
        keyboardAvoidingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        keyboardAvoidingView.addSubview(label)
        keyboardAvoidingView.addSubview(userNameContainer)
        keyboardAvoidingView.addSubview(passwordContainer)
        keyboardAvoidingView.addSubview(loginButton)
        addSubview(keyboardAvoidingView)
        addSubview(errorLabel)
        addSubview(activityIndicatorView)
    }
    
    private func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(140)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(70).priority(.medium)
            make.top.greaterThanOrEqualTo(imageView.snp.bottom).offset(20).priority(.high)

            make.centerX.equalToSuperview()
        }
        
        userNameContainer.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(40)
        }
        
        passwordContainer.snp.makeConstraints { make in
            make.top.equalTo(userNameContainer.snp.bottom).offset(12)
            make.leading.trailing.equalTo(userNameContainer)
            make.height.equalTo(userNameContainer)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaInsets.bottom).offset(-24)
            make.leading.trailing.equalTo(userNameContainer)
            make.height.equalTo(45)
            make.top.greaterThanOrEqualTo(activityIndicatorView).offset(30)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordContainer.snp.bottom).offset(8)
        }
        
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordContainer.snp.bottom).offset(12)
        }
    }
    
    private func setUpViews(title: String) {
        // Container
        backgroundColor = .backgroundColor
        // image view
        imageView.image = UIImage(named: "AppLogo")
        imageView.contentMode = .scaleAspectFit
        // label
        label.text = title
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        // text fields
        usernameTextField.placeholder = "Username"
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.placeholder = "Password"
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.isSecureTextEntry = true
        // password visibilty button
        toggleVisibiltyButton.addTarget(self, action: #selector(togglePasswordVisibilty), for: .touchUpInside)
        toggleVisibiltyButton.setImage(UIImage(named: "iconEyeClose"), for: [])
        // login button
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.backgroundColor = .blueButtonColoe
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        loginButton.setBorder(width: 2, color: .borderColor)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        // error label
        errorLabel.textColor = .systemPink
        errorLabel.isHidden = true
        // activity indicator
        activityIndicatorView.color = .gray
    }
    
    @objc private func togglePasswordVisibilty() {
        passwordTextField.isSecureTextEntry.toggle()
        let iconName = passwordTextField.isSecureTextEntry ? "iconEyeClose" : "iconEyeOpen"
        toggleVisibiltyButton.setImage(UIImage(named: iconName), for: [])
    }
    
    @objc private func login() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        onLoginHandler?(username, password)
        [usernameTextField, passwordTextField].forEach { $0.resignFirstResponder() }
    }
    
    @objc private func textFieldDidChange() {
        errorLabel.text = ""
        errorLabel.isHidden = false
        loginButton.isEnabled = true
    }
}
