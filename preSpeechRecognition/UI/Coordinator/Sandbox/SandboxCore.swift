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
        var items: IdentifiedArrayOf<Item> = []
    }
    
    enum Action {
        case onAppear
        
        case tagButton(id: TagButtonReducer.State.ID, action: TagButtonReducer.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case let .tagButton(id, action):
                return .none // TODO: implement
            }
        }
        .forEach(\.items, action: /Action.tagButton) {
            TagButtonReducer()
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
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tagButtonTapped:
                state.tagButtonStyleType = state.tagButtonStyleType.increment
                print("state.tagButtonStyleType: ", state.tagButtonStyleType)
                return .none
                
            }
        }
    }
}
