//
//  HomeCoordinator.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/29.
//

import Foundation
import UIKit
import SwiftUI
import ComposableArchitecture
import Combine

final class HomeCoordinator: NSObject, NavigationCoordinator {
    let store: StoreOf<HomeCoordinatorReducer>
    let navigationController = UINavigationController()
    
    private lazy var popGestureManager: PopGestureManager = {
        let manager = PopGestureManager()
        manager.navigationController = navigationController
        return manager
    }()
    
    private var cancellables: Set<AnyCancellable> = []

    init(store: StoreOf<HomeCoordinatorReducer>) {
        self.store = store
    }
    
    func start() {
        navigationController.isNavigationBarHidden = true
        
        // enable swipe back
        navigationController.interactivePopGestureRecognizer?.delegate = popGestureManager
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
        
//        navigationController.pushViewController(makeGeneralView(), animated: false)
        
        // TODO: Add some transition (like this)
        
        // When `employeeDetail` is set in State, transition to `EmployeeDetailView`
//        setupTransition(
//            state: \.employeeDetail,
//            action: HomeCoordinatorReducer.Action.employeeDetail,
//            childViewInitializer: EmployeeDetailView.init(store: ),
//            didPopFromNavigation: { [weak self] () in
//                self?.store.send(.didPopFromNavigation(.employeeDetail))
//            }
//        )
    }
}

extension HomeCoordinator {
//    func makeGeneralView() -> UIViewController {
//        return CustomHostingController(rootView: GeneralView())
//    }
}
