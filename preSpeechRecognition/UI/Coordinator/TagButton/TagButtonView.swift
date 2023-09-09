//
//  TagButtonView.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/09/09.
//

import SwiftUI
import ComposableArchitecture

struct TagButtonView: View {
    
    let store: StoreOf<TagButtonReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Button {
                viewStore.send(.tagButtonTapped)
            } label: {
                Text(viewStore.name)
                    .tagButtonText(
                        type: viewStore.tagButtonStyleType,
                        baseColor: viewStore.color
                    )
            }
        }
    }
}

// MARK: - PreviewProvider
struct TagButtonView_Previews: PreviewProvider {
    static let state = TagButtonReducer.State(
        id: .init(),
        name: "hoge",
        color: .cyan
    )
    
    static let store = Store(initialState: state) {
        TagButtonReducer()
    }
    
    static var previews: some View {
        TagButtonView(store: store)
    }
}

