//
//  TagButtonText.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/31.
//

import SwiftUI

extension View {
    func tagButtonText(type: TagButtonText.StyleType) -> some View {
        modifier(TagButtonText(type: type))
    }
}

// MARK: - TagButtonText
struct TagButtonText: ViewModifier {
    let type: StyleType

    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 44)
            .foregroundColor(type.foregroundColor)
            .background {
                type.backgroundView
            }
    }
}

// MARK: - CapsuleType
extension TagButtonText {
    enum StyleType {
        case notSelected
        case selected
        case disabled
        case enabled
        
        fileprivate var foregroundColor: Color {
            switch self {
            case .notSelected:
                return .purple
            case .selected, .disabled, .enabled:
                return .white
            }
        }
        
        @ViewBuilder
        fileprivate var backgroundView: some View {
            switch self {
            case .notSelected:
                Capsule(style: .circular)
                    .stroke(
                        .purple,
                        style: .init(lineWidth: 2, dash: [4])
                    )
            case .selected:
                Capsule(style: .circular)
                    .fill(.gray.opacity(0.4))
            case .disabled:
                ZStack {
                    Capsule(style: .circular)
                        .stroke(
                            .purple.opacity(0.3),
                            style: .init(lineWidth: 14)
                        )
                    
                    Capsule(style: .circular)
                        .fill(.purple)
                }
            case .enabled:
                Capsule(style: .circular)
                    .fill(.purple)
            }
        }
    }
}
