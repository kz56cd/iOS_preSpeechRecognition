//
//  HomeCore.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/29.
//

import Foundation
import ComposableArchitecture

// Reducer corresponding HomeCoordinator.
// Handling screen transition flow.
struct HomeCoordinatorReducer: Reducer {

    struct State: Equatable {
        var general: General.State = .init()
        
        var sandbox: Sandbox.State?
    }
    
    enum Action {
        case general(General.Action)
        case sandbox(Sandbox.Action)
        
        case showSandbox
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            // handling transition actions
            switch action {
                // WIP
            case .general(.sandboxTapped):
                return .send(.showSandbox)
                
            case .sandbox(_):
                return .none
                
            case .showSandbox:
                state.sandbox = Sandbox.State()
                
                print("fuga")
                
                return .none
                
            default:
                return .none
                
            }
        }
        .ifLet(\.sandbox, action: /Action.sandbox) {
            Sandbox()
        }
        
        Scope(state: \.general, action: /Action.general) {
            General()
        }
    }
}
