//
//  CustomHostingController.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2023/08/29.
//

import Foundation
import SwiftUI
import ComposableArchitecture

// This customization is to allow to allow navigation pop by gesture (swiping the edge of the screen) in this app setup (UIKit navigation + SwiftUI)
// `onAppear` of SwiftUI view doesn't work well, e.g. `onAppear` is called in the middle of transition, even when user aborts the pop transition.
// Pop events need to be handed in UIKit, then passed to Reducer in Coordinators, then the reducer can remove associated child states, which corresponds to closing a view.

// A sample in Composable Architecture repository handles this case in a slightly different way, however, this sample didn't work in this app's case, especially at complicated transition, which includes both modal and push transitions.
// https://github.com/pointfreeco/swift-composable-architecture/blob/main/Examples/CaseStudies/UIKitCaseStudies/NavigateAndLoad.swift#L105-L111
final class CustomHostingController<Content: View>: UIHostingController<Content> {

    private let didPopFromNavigation: () -> Void

    @MainActor @objc dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(rootView: Content, didPopFromNavigation: @escaping (() -> Void) = { () in }) {
        self.didPopFromNavigation = didPopFromNavigation
        super.init(rootView: rootView)
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)

        // handle navigation pop
        if parent == nil {
            didPopFromNavigation()
        }
    }
}
