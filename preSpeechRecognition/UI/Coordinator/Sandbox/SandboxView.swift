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
            
            
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 40) {
                    
                    // MEMO:
                    // より正確にフォントサイズに応じてスケールさせたいのであれば @ScaledMetric に準拠したpadding、widthを用意する必要がありそう
                    // ref:
                    // https://developer.apple.com/tutorials/swiftui-concepts/scaling-views-to-complement-text
                    // https://irimasu.com/multiplatform-scaledmetric-environment-geometryproxy-swiftui
                    
                    Button {
                        viewStore.send(.tagButtonTapped)
                    } label: {
                        Text("延べ床面積")
                            .tagButtonText(type: viewStore.tagButtonStyleType)
                    }
                    
                    Text(viewStore.tagButtonDescription)
                    
                }
                .onAppear {
                    // TODO:
                }
                .frame(width: 300, height: 300) // TODO: 画面全域に広げる
                
                Button {
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)

                }
                .padding()
                .opacity(viewStore.isHiddenFloatingButton ? 0 : 1)
                .disabled(viewStore.isHiddenFloatingButton)
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
