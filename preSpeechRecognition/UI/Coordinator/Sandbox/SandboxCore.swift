//
//  SandboxCore.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

struct Sandbox: Reducer {
    typealias Item = TagButtonReducer.State
    
    struct State: Equatable {
        let items: IdentifiedArrayOf<Item>
        
        var tagButtonStyleType: TagButtonText.StyleType = .notSelected
        
        var tagButtonDescription: String {
            tagButtonStyleType.text
        }
        
        var isHiddenFloatingButton: Bool {
            switch tagButtonStyleType {
            case .selected:
                return false
            default:
                return true
            }
        }
    }
    
    enum Action {
        case onAppear
        case tagButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
            
        case .tagButtonTapped:
            state.tagButtonStyleType = state.tagButtonStyleType.increment
            return .none
            
        }
    }
}

// TODO: replace correct file
struct TagButtonReducer: Reducer {
    
    struct Item: Equatable {}
    
    struct State: Equatable, Identifiable {
        let id: UUID
        let name: String
        let color: Color
    }
    
    enum Action {}
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        
    }
}
