//
//  UIViewController+Extensions.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

private struct AssociatedKeys {
    static var transitionDescriptor = "transitionDescriptor"
}

extension UIViewController {
    // MARK: - Properties
    var transitionDescriptor: CTTransitionDescriptor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.transitionDescriptor) as? CTTransitionDescriptor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.transitionDescriptor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
