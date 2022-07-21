//
//  UIViewControllerContextTransitioning+Extensions.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim on 31/10/2021.
//

import UIKit

private struct AssociatedKeys {
    static var resetState = "resetState"
}

extension UIViewControllerContextTransitioning {
    // MARK: - Properties
    
    /// A closure to reset state after applying transition animations.
    var resetState: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.resetState) as? (() -> Void)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.resetState, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Methods
    func getPresentingViewController() -> UIViewController? {
        if let VC = self.viewController(forKey: .from) {
            return VC
        }
        
        return nil
    }
    
    func getPresentingView() -> UIView? {
        if let view = self.viewController(forKey: .from)?.view {
            return view
        }
        
        return nil
    }
    
    func getPresentedViewController() -> UIViewController? {
        if let VC = self.viewController(forKey: .to) {
            return VC
        }
        
        return nil
    }
    
    func getPresentedView() -> UIView? {
        if let view = self.view(forKey: .to) {
            return view
        }
        
        return nil
    }
    
    func getDismissingViewController() -> UIViewController? {
        if let VC = self.viewController(forKey: .to) {
            return VC
        }
        
        return nil
    }
    
    func getDismissingView() -> UIView? {
        if let view = self.viewController(forKey: .to)?.view {
            return view
        }
        
        return nil
    }
    
    func getDismissedViewController() -> UIViewController? {
        if let VC = self.viewController(forKey: .from) {
            return VC
        }
        
        return nil
    }
    
    func getDismissedView() -> UIView? {
        if let view = self.viewController(forKey: .from)?.view {
            return view
        }
        
        return nil
    }
}
