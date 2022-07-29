//
//  ZoomDismissTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class ZoomDismissTransition: CTTransition {
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get required views
        guard let dismissedView = transitionContext.getDismissedView(),
              let dismissingView = transitionContext.getDismissingView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            dismissingView.transform = CGAffineTransform(scaleX: 1, y: 1)
            dismissedView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            dismissedView.layer.cornerRadius = dismissedView.frame.width / 5
            dismissedView.alpha = 0
        }
        
        return animator
    }
}
