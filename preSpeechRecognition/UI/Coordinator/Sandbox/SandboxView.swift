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
            
            List {
                ForEachStore(
                    store.scope(
                        state: \.items,
                        action: Sandbox.Action.tagButton(id: action: )
                    )
                ) { childStore in
                    TagButtonView(store: childStore)
                }
            }

            // use FlowLayout
//            Group {
//                FlowLayout(
//                    mode: .scrollable,
//                    items: viewStore.items.map { $0 }
//                ) { item in
//                    Button {
////                        item.send(.tagButtonTapped)
//                    } label: {
//                        Text(item.name)
//                            .tagButtonText(
//                                type: viewStore.tagButtonStyleType,
//                                baseColor: item.color
//                            )
//                    }
//
//                }
//            }
//            .padding()
        }
    }
}
    
// MARK: - PreviewProvider
struct SandboxView_Previews: PreviewProvider {
    static let items: IdentifiedArrayOf<Sandbox.Item> = [
        .init(id: .init(), name: "hoge", color: .red),
        .init(id: .init(), name: "fuga", color: .blue),
        .init(id: .init(), name: "moga", color: .cyan),
        .init(id: .init(), name: "foo", color: .yellow),
    ]
    
    static let store = Store(initialState: Sandbox.State(items: items)) {
        Sandbox()
    }
    
    static var previews: some View {
        SandboxView(store: store)
    }
}
