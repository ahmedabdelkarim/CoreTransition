//
//  SlideDismissTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class SlideDismissTransition: CTTransition {
    let entranceEdge: CTTransitionEdge
    
    init(entranceEdge: CTTransitionEdge) {
        self.entranceEdge = entranceEdge
    }
    
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get required views
        guard let dismissedVC = transitionContext.getDismissedViewController(),
              let dismissedView = transitionContext.getDismissedView(),
              let dismissingView = transitionContext.getDismissingView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // calculate animation values
        var dismissedViewInitialFrame = transitionContext.initialFrame(for: dismissedVC)
        dismissedViewInitialFrame.origin.x = 0
        
        var dismissedViewFinalFrame = dismissedViewInitialFrame
        switch entranceEdge {
            case .left:
                dismissedViewFinalFrame.origin.x = -dismissedViewInitialFrame.width
            case .right:
                dismissedViewFinalFrame.origin.x = dismissedViewInitialFrame.width
            case .top:
                dismissedViewFinalFrame.origin.y = -dismissedViewInitialFrame.height
            case .bottom:
                dismissedViewFinalFrame.origin.y = dismissedViewInitialFrame.height
        }
        
        var dismissingViewInitialFrame = dismissedViewInitialFrame
        switch entranceEdge {
            case .left:
                dismissingViewInitialFrame.origin.x = dismissedViewInitialFrame.size.width
            case .right:
                dismissingViewInitialFrame.origin.x = -dismissedViewInitialFrame.size.width
            case .top:
                dismissingViewInitialFrame.origin.y = dismissedViewInitialFrame.size.height
            case .bottom:
                dismissingViewInitialFrame.origin.y = -dismissedViewInitialFrame.size.height
        }
        
        // set initial values
        dismissingView.frame = dismissingViewInitialFrame
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            dismissingView.frame = dismissedViewInitialFrame
            dismissedView.frame = dismissedViewFinalFrame
        }
        
        return animator
    }
}
