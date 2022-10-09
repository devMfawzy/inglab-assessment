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
        let rootViewController = PeopleListViewController()
        rootViewController.delegate = self
        changeRootViewController(navigationController, window: window)
        navigationController.pushViewController(rootViewController, animated: false)
    }
}

extension HomeCoordinator: PeopleListViewControllerDelegate {
    func showDetailsOf(person: Person) {
        let viewController = PersonDetailsViewController(person: person)
        navigationController.pushViewController(viewController, animated: true)
    }
}
