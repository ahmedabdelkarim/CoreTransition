//
//  UIViewPropertyAnimator+Extensions.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

extension UIViewPropertyAnimator {
    // MARK: - Properties
    static var empty: UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0, curve: .linear) { }
    }
}
