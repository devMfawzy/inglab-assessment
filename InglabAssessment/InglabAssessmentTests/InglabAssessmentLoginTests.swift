//
//  InglabAssessmentTests.swift
//  InglabAssessmentTests
//
//  Created by Mohamed Fawzy on 10/10/2022.
//

import XCTest
@testable import InglabAssessment

final class InglabAssessmentLoginTests: XCTestCase {
    var sut: LoginViewModeling!
    
    func viewModel(withValidLogin validLogin: Bool = false) -> LoginViewModeling {
        return LoginViewModel(service: MockLoginService(isValidLogin: validLogin))
    }

    override func tearDown()  {
        sut = nil
    }

    func test_login_when_userOrPassword_are_invalid() {
        // given
        sut = viewModel(withValidLogin: false)
        let expected = false
        var actual: Bool?
        // when
        let expectation = expectation(description: "login expectation")
        sut.onSuccess {
            fatalError("not expected to succeed")
        }
        sut.onError { _ in
            actual = false
            expectation.fulfill()
        }
        sut.loginWith(username: "any", password: "any")
        // then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(expected, actual)
    }
    
    func test_login_when_userOrPassword_are_Valid() {
        // given
        sut = viewModel(withValidLogin: true)
        let expected = true
        var actual: Bool?
        let expectation = expectation(description: "login expectation")
        // when
        sut.onSuccess {
            actual = true
            expectation.fulfill()
        }
        sut.onError { _ in
            fatalError("not expected to get error")
        }
        sut.loginWith(username: "any", password: "any")
        // then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(expected, actual)
    }
    
   func test_login_when_userNameIsEmpty() {
        // given
        sut = viewModel()
        let expected = LoginValidationError.missingUsername
        var actual: LoginValidationError?
        let expectation = expectation(description: "missing  Username expectation")
        // when
        sut.onValidationError { error in
            actual = error
            expectation.fulfill()
        }
        sut.onSuccess {
            fatalError("not expected to get success status")
        }
        sut.onError { _ in
            fatalError("not expected to call network get success status")
        }
        sut.loginWith(username: "", password: "password")
        // then
        wait(for: [expectation], timeout: 0.2)
        XCTAssertEqual(expected, actual)
    }
    
    func test_login_when_passwordIsEmpty() {
         // given
         sut = viewModel()
         let expected = LoginValidationError.missingPassword
         var actual: LoginValidationError?
         let expectation = expectation(description: "missing  Username expectation")
         // when
         sut.onValidationError { error in
             actual = error
             expectation.fulfill()
         }
         sut.onSuccess {
             fatalError("not expected to get success status")
         }
         sut.onError { _ in
             fatalError("not expected to call network get success status")
         }
         sut.loginWith(username: "username", password: "")
         // then
         wait(for: [expectation], timeout: 0.2)
         XCTAssertEqual(expected, actual)
     }
    
    func test_login_when_UserName_and_password_empty() {
         // given
         sut = viewModel()
         let expected = LoginValidationError.missingUserNameAndPassword
         var actual: LoginValidationError?
         let expectation = expectation(description: "missing  Username expectation")
         // when
         sut.onValidationError { error in
             actual = error
             expectation.fulfill()
         }
         sut.onSuccess {
             fatalError("not expected to get success status")
         }
         sut.onError { _ in
             fatalError("not expected to call network get success status")
         }
         sut.loginWith(username: "", password: "")
         // then
         wait(for: [expectation], timeout: 0.2)
         XCTAssertEqual(expected, actual)
     }
}

fileprivate class MockLoginService: LoginServiceProtocol {
    let validLogin: Bool
    
    init(isValidLogin: Bool) {
        self.validLogin = isValidLogin
    }
    
    func login(username: String, password: String, completion: @escaping (InglabAssessment.LoginResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(1)) { [weak self] in
            if self?.validLogin ?? false {
                completion(.sucsess)
            } else {
                completion(.error("any message"))
            }
        }
    }
}
