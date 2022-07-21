//
//  UIViewPropertyAnimator+Extensions.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim on 31/10/2021.
//

import UIKit

extension UIViewPropertyAnimator {
    // MARK: - Properties
    static var empty: UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0, curve: .linear) { }
    }
}
