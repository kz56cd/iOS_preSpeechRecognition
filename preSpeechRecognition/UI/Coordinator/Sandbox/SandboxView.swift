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
    
//    private let items = ["Some long item here", "And then some longer one",
//                 "Short", "Items", "Here", "And", "A", "Few", "More",
//                 "And then a very very very long long long long long long long long longlong long long long long long longlong long long long long long longlong long long long long long longlong long long long long long longlong long long long long long long long one", "and", "then", "some", "short short short ones"]
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            FlowLayout(
                mode: .scrollable,
                items: viewStore.items
            ) { item in
                Button {
                    viewStore.send(.tagButtonTapped)
                } label: {
                    Text(item.name)
                        .tagButtonText(
                            type: viewStore.tagButtonStyleType,
                            baseColor: item.color
                        )
                }

            }
        }
    }
}
    
// MARK: - PreviewProvider
struct SandboxView_Previews: PreviewProvider {
    
    static let items: [Sandbox.Item] = [.init(name: "hoge", color: .red)]
    
    static let store = Store(initialState: Sandbox.State(items: items)) {
        Sandbox()
    }
    
    static var previews: some View {
        SandboxView(store: store)
    }
}
