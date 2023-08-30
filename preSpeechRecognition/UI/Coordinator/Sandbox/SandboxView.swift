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
            
            VStack(spacing: 40) {
                Text("Sandbox")
                
                // MEMO:
                // より正確にフォントサイズに応じてスケールさせたいのであれば @ScaledMetric に準拠したpadding、widthを用意する必要がありそう
                // ref:
                // https://developer.apple.com/tutorials/swiftui-concepts/scaling-views-to-complement-text
                // https://irimasu.com/multiplatform-scaledmetric-environment-geometryproxy-swiftui
                
                // v1
                Button {
                    viewStore.send(.tagButtonTapped)
//                    print("tag tapped.")
                } label: {
                    Text("延べ床面積")
                        .tagButtonText(type: viewStore.tagButtonStyleType)
                    
//                    Text("延べ床面積")
//                        .tagButtonText(type: .selected)

                }

//                // v2
//                Button {
//                    print("tag tapped.")
//                } label: {
//                    Text("延べ床面積")
//                        .tagButtonText(type: .selected)
//                }
//
//                Button {
//                    print("tag tapped.")
//                } label: {
//                    Text("延べ床面積")
//                        .tagButtonText(type: .disabled)
//                }
//
//                // tag button (v4)
//                Button {
//                    print("tag tapped.")
//                } label: {
//                    Text("延べ床面積")
//                        .tagButtonText(type: .enabled)
//                }
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
