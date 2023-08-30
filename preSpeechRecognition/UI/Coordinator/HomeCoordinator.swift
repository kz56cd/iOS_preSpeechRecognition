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
        
        // Add root view
        navigationController.pushViewController(makeGeneralView(), animated: false)
        
        // Add some transition
        setupTransition(
            state: \.sandbox,
            action: HomeCoordinatorReducer.Action.sandbox,
            childViewInitializer: SandboxView.init(store: ),
            didPopFromNavigation: { [weak self] () in
                // TODO:
            }
        )
    }
}

// MARK: - private
private extension HomeCoordinator {
    func makeGeneralView() -> UIViewController {
        let view = GeneralView(
            store: store.scope(
                state: \.general,
                action: HomeCoordinatorReducer.Action.general
            )
        )
        
        return CustomHostingController(rootView: view)
    }
    
    // Logic for transition when state (existence of child states) changes in HomeCoordinatorReducer.
    //
    // When the child state becomes non-null in state (by some logic in reducer), make view, make hostingVC, then push to navigationController.
    // When the child state becomes null, pop the view from navigation controller.
    // (Basically, syncing the state between HomeCoordinatorReducer.State ane navigation stack)
    // Reference: https://github.com/pointfreeco/swift-composable-architecture/blob/main/Examples/CaseStudies/UIKitCaseStudies/LoadThenNavigate.swift#L100-L113
    func setupTransition<ChildState, ChildAction, ChildView: View>(
        state toChildState: @escaping (HomeCoordinatorReducer.State) -> ChildState?,
        action fromChildAction: @escaping (ChildAction) -> HomeCoordinatorReducer.Action,
        childViewInitializer: @escaping (Store<ChildState, ChildAction>) -> ChildView,
        didPopFromNavigation: @escaping () -> ()
    ) {
        store
            .scope(state: toChildState, action: fromChildAction) // observe child state existence change
            .ifLet(
                then: { [weak self] childStore in
                    // When the child state becomes non-null in state, make view, make hostingVC, then push to navigationController.
                    
                    guard let self = self else {
                        return
                    }
                    
                    let view = childViewInitializer(childStore)
                    
                    let vc = CustomHostingController(
                        rootView: view,
                        didPopFromNavigation: { () in
                            didPopFromNavigation()
                        }
                    )
                    self.navigationController.pushViewController(vc, animated: true)
                },
                else: { [weak self] () in
                    // When the child state becomes null, pop the view from navigation controller.
                    guard let self = self else {
                        return
                    }
                    DispatchQueue.main.async {
                        if self.navigationController.viewControllers.last is UIHostingController<ChildView> {
                            self.navigationController.popViewController(animated: true)
                        }
                    }
                }
            )
            .store(in: &cancellables)
    }
}
