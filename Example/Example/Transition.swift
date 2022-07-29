//
//  Transition.swift
//  Example
//
//  Created by Ahmed Abdelkarim on 24/07/2022.
//

import Foundation
import CoreTransition
import UIKit

struct Transition {
    internal init(name: String, description: String, icon: UIImage?, background: UIColor, borderColor: UIColor, titleColor: UIColor, cornerRadius: CGFloat, style: CTTransitionStyle?, duration: TimeInterval, size: CGSize? = nil) {
        self.name = name
        self.description = description
        self.icon = icon
        self.background = background
        self.borderColor = borderColor
        self.titleColor = titleColor
        self.cornerRadius = cornerRadius
        self.style = style
        self.duration = duration
        self.size = size
    }
    
    let name: String
    let description: String
    let icon: UIImage?
    let background: UIColor
    let borderColor: UIColor
    let titleColor: UIColor
    let cornerRadius: CGFloat
    var style: CTTransitionStyle?
    let duration: TimeInterval
    let size: CGSize?
}
