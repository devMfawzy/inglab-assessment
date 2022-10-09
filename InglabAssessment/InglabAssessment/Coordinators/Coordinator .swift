//
//  Coordinator .swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

extension Coordinator {
    func changeRootViewController(_ viewController: UIViewController, window: UIWindow) {
        window.rootViewController = viewController
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionCrossDissolve],
                          animations: nil,
                          completion: nil)
        window.makeKeyAndVisible()
    }
}
