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
//        var general: Dashboard.State = .init()
    }
    
    enum Action {
        // case dashboard(Dashboard.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            // handling transition actions
            switch action {
                // WIP
            }
        }
//        .ifLet(\.employeeDetail, action: /Action.employeeDetail) {
//            EmployeeDetail()
//        }
        
//        Scope(state: \.dashboard, action: /Action.dashboard) {
//            Dashboard()
//        }
    }
}
