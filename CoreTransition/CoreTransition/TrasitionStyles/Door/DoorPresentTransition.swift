//
//  DoorPresentTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class DoorPresentTransition: CTTransition {
    let openingEdge: CTTransitionEdge
    
    // Smaller -> Closer to the 'camera', more distorted
    let skewFactor = CGFloat(1.0 / 1000.0)
    
    init(openingEdge: CTTransitionEdge) {
        self.openingEdge = openingEdge
    }
    
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get required views
        guard let presentingVC = transitionContext.getPresentingViewController(),
              let presentingView = transitionContext.getPresentingView(),
              let presentedView = transitionContext.getPresentedView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        // get screenshot image
        let screenshotImage = presentingView.getScreenshot()
        
        let imageView = UIImageView(image: screenshotImage)
        
        // calculate animation values
        let presentingViewInitialFrame = transitionContext.initialFrame(for: presentingVC)
        let imageViewInitialFrame = presentingViewInitialFrame
        
        var imageRotationTransform = CATransform3DIdentity
        switch openingEdge {
            case .left:
                imageView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
                imageView.layer.position = CGPoint(x: imageViewInitialFrame.width, y: imageViewInitialFrame.height / 2)
                
                imageRotationTransform.m34 = skewFactor
                imageRotationTransform = CATransform3DRotate(imageRotationTransform, CGFloat.pi / 2, 0, 1, 0)
            case .right:
                imageView.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
                imageView.layer.position = CGPoint(x: 0.0, y: imageViewInitialFrame.height / 2)
                
                imageRotationTransform.m34 = skewFactor
                imageRotationTransform = CATransform3DRotate(imageRotationTransform, -CGFloat.pi / 2, 0, 1, 0)
            case .top:
                imageView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
                imageView.layer.position = CGPoint(x: imageViewInitialFrame.width / 2, y: presentingView.frame.height)
                
                imageRotationTransform.m34 = skewFactor
                imageRotationTransform = CATransform3DRotate(imageRotationTransform, -CGFloat.pi / 2, 1, 0, 0)
            case .bottom:
                imageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
                imageView.layer.position = CGPoint(x: imageViewInitialFrame.width / 2, y: 0.0)
                
                imageRotationTransform.m34 = skewFactor
                imageRotationTransform = CATransform3DRotate(imageRotationTransform, CGFloat.pi / 2, 1, 0, 0)
        }
        
        // set initial values
        imageView.frame = imageViewInitialFrame
        
        presentingView.alpha = 0
        
        // MOST IMPORTANT: set z position to appear above other views
        imageView.layer.zPosition = 100
        
        // add views in transition container
        let transitionContainer = transitionContext.containerView
        transitionContainer.insertSubview(presentedView, at: 0)
        transitionContainer.addSubview(imageView)
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {
            imageView.layer.transform = imageRotationTransform
        }
        
        // reset state
        transitionContext.resetState = {
            // remove images to free memory space
            imageView.removeFromSuperview()
        }
        
        return animator
    }
}
