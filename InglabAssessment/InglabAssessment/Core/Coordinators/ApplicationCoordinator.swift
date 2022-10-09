//
//  ApplicationCoordinator.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    var subCoordinator: Coordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        switchRootViewController()
    }
}

extension ApplicationCoordinator: LoginCoordinatorDelegate {
    func switchRootViewController() {
        if User.shared.isLoggedIn {
            subCoordinator = HomeCoordinator(window: window)
            subCoordinator?.start()
        } else {
            let loginCoordinator = LoginCoordinator(window: window)
            loginCoordinator.delegate = self
            subCoordinator = loginCoordinator
            subCoordinator?.start()
        }
    }
}
