//
//  SceneCore.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/29.
//

import Foundation
import ComposableArchitecture

// Reducer corresponding SceneDelegate.
struct SceneReducer: Reducer {
    
//    @Dependency(\.apiClient) var apiClient
    
    struct State: Equatable {
        var home: HomeCoordinatorReducer.State?
    }
    
    enum Action {
        case willConnect
        case home(HomeCoordinatorReducer.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .willConnect:
                state.home = .init()
                return .none
                
            case .home:
                return .none
            }
        }
        .ifLet(\.home, action: /Action.home) {
            HomeCoordinatorReducer()
        }
    }
}
