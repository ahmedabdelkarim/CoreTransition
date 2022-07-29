//
//  PuzzleBoardDismissTransition.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

class PuzzleBoardDismissTransition: CTTransition {
    let orientation: CTTransitionOrientation
    
    init(orientation: CTTransitionOrientation) {
        self.orientation = orientation
    }
    
    override func buildAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // get required views
        guard let dismissingView = transitionContext.getDismissingView(),
              let dismissedView = transitionContext.getDismissedView()
        else {
            return UIViewPropertyAnimator.empty
        }
        
        let transitionContainer = transitionContext.containerView
        
        // get screenshot images
        var rows = 0, columns = 0
        
        if dismissingView.frame.width < dismissingView.frame.height {
            columns = 5
            rows = columns * Int(dismissingView.frame.height / dismissingView.frame.width)
        }
        else {
            rows = 5
            columns = rows * Int(dismissingView.frame.width / dismissingView.frame.height)
        }
        
        let portions = dismissedView.getImagePortions(rows: rows, columns: columns)
        
        // setup portion images
        var portionImageViews = [UIImageView]()
        
        for rowPortions in portions {
            for portion in rowPortions {
                let portionImageView = UIImageView(image: portion.image)
                
                // set frame
                portionImageView.frame = portion.frame
                
                // set transform
                // portionImageView.layer.anchorPoint = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
                
                // TODO: - fix translate animation
                let finalTransform = CGAffineTransform(translationX: CGFloat.random(in: -portion.frame.width/4...portion.frame.width/4), y: dismissingView.frame.height * 1.2).rotated(by: CGFloat.random(in: -60...60))
                
                // let finalTransform = CGAffineTransform(rotationAngle: CGFloat.random(in: -60...60)).translatedBy(x: CGFloat.random(in: -portion.frame.width/4...portion.frame.width/4), y: dismissingView.frame.height * 1.2)
                
                portionImageView.finalAffineTransform = finalTransform
                
                // add image view
                portionImageView.layer.zPosition = 100 // to make it appear above all other views
                
                transitionContainer.addSubview(portionImageView)
                
                portionImageViews.append(portionImageView)
            }
        }
        
        // hide dismissedView
        dismissedView.alpha = 0
        
        // setup animator
        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeIn) {
            
            for imageView in portionImageViews {
                imageView.transform = imageView.finalAffineTransform!
            }
            
        }
        
        return animator
    }
}
