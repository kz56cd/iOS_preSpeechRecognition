//
//  Coordinator.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/29.
//

import UIKit

protocol Coordinator {
    var rootViewController: UIViewController { get }
    func start()
}

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
}

extension NavigationCoordinator {
    var rootViewController: UIViewController {
        navigationController
    }
}

class PopGestureManager: NSObject, UIGestureRecognizerDelegate {
    weak var navigationController: UINavigationController?
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController else {
            return false
        }
        
        return navigationController.viewControllers.count > 1
    }
}
