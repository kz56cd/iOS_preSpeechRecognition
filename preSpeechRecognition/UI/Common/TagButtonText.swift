//
//  TagButtonText.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/31.
//

import SwiftUI

extension View {
    func tagButtonText(
        type: TagButtonText.StyleType,
        baseColor: Color
    ) -> some View {
        modifier(TagButtonText(type: type, baseColor: baseColor))
    }
}

// MARK: - TagButtonText
struct TagButtonText: ViewModifier {
    let type: StyleType
    let baseColor: Color

    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 44)
            .foregroundColor(type.foregroundColor(baseColor: baseColor))
            .background {
                type.backgroundView(baseColor: baseColor)
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
        
        var text: String {
            switch self {
            case .notSelected:
                return "notSelected"
            case .selected:
                return "selected"
            case .disabled:
                return "disabled"
            case .enabled:
                return "enabled"
            }
        }
        
        func foregroundColor(baseColor: Color) -> Color {
            switch self {
            case .notSelected:
                return baseColor
            case .selected, .disabled, .enabled:
                return Color.white
            }
        }
        
        @ViewBuilder
        func backgroundView(baseColor: Color) -> some View {
            switch self {
            case .notSelected:
                Capsule(style: .circular)
                    .stroke(
                        baseColor,
                        style: .init(lineWidth: 2, dash: [4])
                    )
            case .selected:
                ZStack {
                    Capsule(style: .circular)
                        .stroke(
                            baseColor.opacity(0.3),
                            style: .init(lineWidth: 14)
                        )
                    
                    Capsule(style: .circular)
                        .fill(baseColor)
                }
            case .disabled:
                Capsule(style: .circular)
                    .fill(.gray.opacity(0.4))
            case .enabled:
                Capsule(style: .circular)
                    .fill(baseColor)
            }
        }
    }
}
