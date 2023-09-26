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
                
            case .general(.onAppear):
                // NOTE:
                // 作業中の画面を即時表示したいときは下記コードを実行
                return .run { send in
                    await send(.showSandbox)
                }
                
//                return .none
                
            case .general(.sandboxTapped):
                return .send(.showSandbox)
                
            case .sandbox(_):
                return .none
                
            case .showSandbox:
                state.sandbox = Sandbox.State(
                    items: [
                        .init(id: .init(), name: "hoge", color: .red),
                        .init(id: .init(), name: "fuga", color: .blue),
                        .init(id: .init(), name: "moga", color: .cyan),
                        .init(id: .init(), name: "foo", color: .yellow)
                    ]
                )
                
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
