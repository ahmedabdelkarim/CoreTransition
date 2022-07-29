//
//  CurtainZoomDismissTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class CurtainZoomDismissTransition: CTTransition {
    let orientation: CTTransitionOrientation
    
    init(orientation: CTTransitionOrientation) {
        self.orientation = orientation
    }
    
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get required views
        guard let dismissedView = transitionContext.getDismissedView(),
              let dismissingView = transitionContext.getDismissingView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // reset alpha to 1 to be able to take screenshot (it's set to 0 in present transition)
        dismissingView.alpha = 1
        
        // update screenshots of images to match presenting view at this time
        let (firstHalfImage, firstHalfFrame, secondHalfImage, secondHalfFrame) = orientation == .horizontal ? dismissingView.getHorizontalHalfImages() : dismissingView.getVerticalHalfImages()
        
        let firstImageView = UIImageView(image: firstHalfImage)
        let secondImageView = UIImageView(image: secondHalfImage)
        
        // calculate animation values
        let firstImageViewFinalFrame = firstHalfFrame
        var firstImageViewInitialFrame = firstHalfFrame
        switch orientation {
            case .horizontal:
                firstImageViewInitialFrame.origin.x = -firstHalfFrame.size.width
            case .vertical:
                firstImageViewInitialFrame.origin.y = -firstHalfFrame.size.height
        }
        
        let secondImageViewFinalFrame = secondHalfFrame
        var secondImageViewInitialFrame = secondHalfFrame
        switch orientation {
            case .horizontal:
                secondImageViewInitialFrame.origin.x = secondHalfFrame.size.width * 2
            case .vertical:
                secondImageViewInitialFrame.origin.y = secondHalfFrame.size.height * 2
        }
        
        // set initial values
        firstImageView.frame = firstImageViewInitialFrame
        secondImageView.frame = secondImageViewInitialFrame
        
        // add views in transition container
        let transitionContainer = transitionContext.containerView
        transitionContainer.addSubview(firstImageView)
        transitionContainer.addSubview(secondImageView)
        
        // hide dismissing view because it appears during zoom animation of dismissedView
        dismissingView.alpha = 0
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            firstImageView.frame = firstImageViewFinalFrame
            secondImageView.frame = secondImageViewFinalFrame
            
            dismissedView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            dismissedView.layer.cornerRadius = dismissingView.frame.width / 5
        }
        
        // reset state
        transitionContext.resetState = {
            // show dismissing again when animation completed
            dismissingView.alpha = 1
        }
        
        return animator
    }
}
