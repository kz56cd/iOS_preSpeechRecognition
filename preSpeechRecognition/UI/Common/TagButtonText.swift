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
    enum StyleType: Int {
        case notSelected = 0
        case selected = 1
        case disabled = 2
        case enabled = 3
        
        // for test
        var increment: Self {
            let rawValue = self.rawValue + 1
            guard rawValue <= StyleType.enabled.rawValue else { return .notSelected }
            return .init(rawValue: rawValue) ?? .notSelected
        }
        
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
                ZStack {
                    Capsule(style: .circular)
                        .stroke(
                            .purple.opacity(0.3),
                            style: .init(lineWidth: 14)
                        )
                    
                    Capsule(style: .circular)
                        .fill(.purple)
                }
            case .disabled:
                Capsule(style: .circular)
                    .fill(.gray.opacity(0.4))
            case .enabled:
                Capsule(style: .circular)
                    .fill(.purple)
            }
        }
    }
}
