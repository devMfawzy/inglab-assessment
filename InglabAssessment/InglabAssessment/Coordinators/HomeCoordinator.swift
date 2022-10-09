//
//  HomeCoordinator.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import UIKit

class HomeCoordinator: Coordinator {
    let navigationController: UINavigationController
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let rootViewController = UsersListViewController()
        changeRootViewController(navigationController, window: window)
        navigationController.pushViewController(rootViewController, animated: false)
    }
}
