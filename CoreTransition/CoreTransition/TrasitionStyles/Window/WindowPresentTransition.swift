//
//  WindowPresentTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class WindowPresentTransition: CTTransition {
    let orientation: CTTransitionOrientation
    
    // Smaller -> Closer to the 'camera', more distorted
    let skewFactor = CGFloat(1.0 / 1000.0)
    
    init(orientation: CTTransitionOrientation) {
        self.orientation = orientation
    }
    
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get required views
        guard let presentingView = transitionContext.getPresentingView(),
              let presentedView = transitionContext.getPresentedView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // get screenshot half images
        let (firstHalfImage, firstHalfFrame, secondHalfImage, secondHalfFrame) = orientation == .horizontal ? presentingView.getHorizontalHalfImages() : presentingView.getVerticalHalfImages()
        
        let firstImageView = UIImageView(image: firstHalfImage)
        let secondImageView = UIImageView(image: secondHalfImage)
        
        // calculate animation values
        let firstImageViewInitialFrame = firstHalfFrame
        var firstRotationTransform = CATransform3DIdentity
        switch orientation {
            case .horizontal:
                firstImageView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
                firstImageView.layer.position = CGPoint(x: 0.0, y: presentingView.frame.height / 2)
                
                firstRotationTransform.m34 = skewFactor
                firstRotationTransform = CATransform3DRotate(firstRotationTransform, -CGFloat.pi / 2, 0, 1, 0)
            case .vertical:
                firstImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
                firstImageView.layer.position = CGPoint(x: presentingView.frame.width / 2, y: 0.0)
                
                firstRotationTransform.m34 = skewFactor
                firstRotationTransform = CATransform3DRotate(firstRotationTransform, CGFloat.pi / 2, 1, 0, 0)
        }
        
        let secondImageViewInitialFrame = secondHalfFrame
        var secondRotationTransform = CATransform3DIdentity
        switch orientation {
            case .horizontal:
                secondImageView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
                secondImageView.layer.position = CGPoint(x: presentingView.frame.width, y: presentingView.frame.height / 2)
                
                secondRotationTransform.m34 = skewFactor
                secondRotationTransform = CATransform3DRotate(secondRotationTransform, CGFloat.pi / 2, 0, 1, 0)
            case .vertical:
                secondImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
                secondImageView.layer.position = CGPoint(x: presentingView.frame.width / 2, y: presentingView.frame.height)
                
                secondRotationTransform.m34 = skewFactor
                secondRotationTransform = CATransform3DRotate(secondRotationTransform, -CGFloat.pi / 2, 1, 0, 0)
        }
        
        // set initial values
        firstImageView.frame = firstImageViewInitialFrame
        secondImageView.frame = secondImageViewInitialFrame
        
        presentingView.alpha = 0
        
        // MOST IMPORTANT: set z position to appear above other views
        firstImageView.layer.zPosition = 100
        secondImageView.layer.zPosition = 100
        
        // add views in transition container
        let transitionContainer = transitionContext.containerView
        transitionContainer.insertSubview(presentedView, at: 0)
        transitionContainer.addSubview(firstImageView)
        transitionContainer.addSubview(secondImageView)
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            firstImageView.layer.transform = firstRotationTransform
            secondImageView.layer.transform = secondRotationTransform
        }
        
        // reset state
        transitionContext.resetState = {
            // remove images to free memory space
            firstImageView.removeFromSuperview()
            secondImageView.removeFromSuperview()
        }
        
        return animator
    }
}
