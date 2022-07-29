//
//  CoverPresentTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class CoverPresentTransition: CTTransition {
    let entranceEdge: CTTransitionEdge
    
    init(entranceEdge: CTTransitionEdge) {
        self.entranceEdge = entranceEdge
    }
    
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get transition container
        let transitionContainer = transitionContext.containerView
        
        // get required views
        guard let presentingVC = transitionContext.getPresentingViewController(),
              let presentingView = transitionContext.getPresentingView(),
              let presentedView = transitionContext.getPresentedView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // calculate animation values
        let presentingViewInitialFrame = transitionContext.initialFrame(for: presentingVC)
        let presentingViewFinalFrame = presentingViewInitialFrame
        
        var presentedViewInitialFrame = presentingViewInitialFrame
        switch entranceEdge {
            case .left:
                presentedViewInitialFrame.origin.x = -presentingViewInitialFrame.width
            case .right:
                presentedViewInitialFrame.origin.x = presentingViewInitialFrame.width
            case .top:
                presentedViewInitialFrame.origin.y = -presentingViewInitialFrame.height
            case .bottom:
                presentedViewInitialFrame.origin.y = presentingViewInitialFrame.height
        }
        
        let presentedViewFinalFrame = presentingViewInitialFrame
        
        // set initial values
        presentedView.frame = presentedViewInitialFrame
        
        // add views in transition container
        transitionContainer.addSubview(presentedView)
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            presentingView.frame = presentingViewFinalFrame
            presentedView.frame = presentedViewFinalFrame
        }
        
        return animator
    }
}
