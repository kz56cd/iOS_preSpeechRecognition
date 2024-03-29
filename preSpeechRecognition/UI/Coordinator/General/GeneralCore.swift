//
//  GeneralCore.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/30.
//

import Foundation
import ComposableArchitecture

struct General: Reducer {
    
    struct State: Equatable {
        
    }
    
    enum Action {
        case onAppear
        
        // buttons
        case sandboxTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
            
        case .sandboxTapped:
            return .none // handled by HomeReducer (as this is a transition)
        }
    }
}
