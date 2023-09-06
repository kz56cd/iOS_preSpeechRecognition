//
//  SandboxCore.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

struct Sandbox: Reducer {
//    typealias Item = TagButtonReducer
    typealias Item = TagButtonReducer.State
    
    struct State: Equatable {
        let items: IdentifiedArrayOf<Item>
    }
    
    enum Action {
        case onAppear
        
        case tagButton(id: TagButtonReducer.State.ID, action: TagButtonReducer.Action)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
        case let .tagButton(id, action):
            return .none // TODO: implement
        }
    }
}

// TODO: replace correct file
//struct TagButtonReducer: Reducer, Identifiable {
//    let id = UUID()

struct TagButtonReducer: Reducer {
    
    struct Item: Equatable {}
    
    struct State: Equatable, Identifiable {
        let id: UUID
        let name: String
        let color: Color
        
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
        case tagButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            case .tagButtonTapped:
                state.tagButtonStyleType = state.tagButtonStyleType.increment
                return .none
        }
    }
}
