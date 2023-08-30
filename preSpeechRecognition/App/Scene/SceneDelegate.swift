//
//  SceneDelegate.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/29.
//

import UIKit
import ComposableArchitecture
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let store: StoreOf<SceneReducer> = Store(
        initialState: SceneReducer.State(),
        reducer: { SceneReducer()._printChanges() },
        withDependencies: { _ in } // Add mock data (if needed)
    )
    
    private var homeCoordinator: HomeCoordinator?
    private var cancellables: Set<AnyCancellable> = []
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        setupHomeTransition()
        
        // TODO:
         store.send(.willConnect)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

private extension SceneDelegate {
    func setupHomeTransition() {
        store.scope(state: \.home, action: SceneReducer.Action.home)
            .ifLet(
                then: { [weak self] homeStore in
                    guard let self = self else {
                        return
                    }

                    let coordinator = HomeCoordinator(store: homeStore)
                    self.window?.rootViewController = coordinator.rootViewController
                    self.window?.makeKeyAndVisible()
                    coordinator.start()
                    self.homeCoordinator = coordinator
                },
                else: { [weak self] () in
                    self?.homeCoordinator = nil
                }
            )
            .store(in: &cancellables)
    }
}
