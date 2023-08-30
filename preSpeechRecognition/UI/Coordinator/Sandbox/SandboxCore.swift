//
//  SandboxCore.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/30.
//

import Foundation
import ComposableArchitecture

struct Sandbox: Reducer {
    
    struct State: Equatable {
        
    }
    
    enum Action {
        case onAppear
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
        }
    }
}
