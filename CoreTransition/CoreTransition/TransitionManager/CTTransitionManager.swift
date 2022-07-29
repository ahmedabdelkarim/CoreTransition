//
//  CTTransitionManager.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//
//
import Foundation
import UIKit

public class CTTransitionManager: NSObject {
    // MARK: - Properties
    
    /// The default transition style for all transition animations.
    ///
    /// This value is used if no style is set for each individual call to transitions.
    ///
    /// **Default:** Cover from Right edge
    // public var defaultTransitionStyle: CTTransitionStyle = .cover(entranceEdge: .right)
    
    /// The default duration for transition animations.
    ///
    /// This value is used if no duration is set for each individual call to transitions.
    ///
    /// **Default:** 0.75 second
    public var defaultTransitionDuration: TimeInterval = 0.75
    
    // MARK: - Methods
    public func transition(from presenting: UIViewController, to presented: UIViewController, style: CTTransitionStyle, duration: TimeInterval? = nil, completion: (() -> Void)? = nil) {
        presented.modalPresentationStyle = .custom
        presented.transitioningDelegate = self
        
        let transitionDuration = duration ?? defaultTransitionDuration
        
        let transitionDescriptor =  style.descriptor
        transitionDescriptor.presentTransition.duration = transitionDuration
        transitionDescriptor.dismissTransition.duration = transitionDuration
        
        presented.transitionDescriptor = transitionDescriptor
        
        presenting.present(presented, animated: true, completion: completion)
    }
}

extension CTTransitionManager: UIViewControllerTransitioningDelegate {
    public final func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let transitionDescriptor = presented.transitionDescriptor
        else {
            return CTTransition()
        }
        
        let transition = transitionDescriptor.presentTransition
        
        return transition
    }
    
    public final func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let transitionDescriptor = dismissed.transitionDescriptor
        else {
            return CTTransition()
        }
        
        let transition = transitionDescriptor.dismissTransition
        
        return transition
    }
}
