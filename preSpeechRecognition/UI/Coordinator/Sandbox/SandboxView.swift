//
//  SandboxView.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

struct SandboxView: View {
    
    let store: StoreOf<Sandbox>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            VStack {
                Text("Sandbox")
            }
            .onAppear {
                // TODO:
            }
        }
    }
}
    
// MARK: - PreviewProvider
struct SandboxView_Previews: PreviewProvider {
    static let store = Store(initialState: Sandbox.State()) {
        Sandbox()
    }
    
    static var previews: some View {
        SandboxView(store: store)
    }
}
