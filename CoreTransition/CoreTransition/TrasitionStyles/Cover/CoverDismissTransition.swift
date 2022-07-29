//
//  CoverDismissTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class CoverDismissTransition: CTTransition {
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
        let dismissedViewInitialFrame = transitionContext.initialFrame(for: dismissedVC)
        
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
        
        let dismissingViewInitialFrame = dismissedViewInitialFrame
        
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
