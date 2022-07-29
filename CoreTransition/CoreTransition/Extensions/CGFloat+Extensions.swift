//
//  CGFloat+Extensions.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

extension CGFloat {
    /// Get random value from multiple ranges.
    /// - Parameter ranges: Array of ranges.
    /// - Returns: The random selected value among all values in all ranges.
    static func randomFromRanges(_ ranges: [ClosedRange<CGFloat>]) -> CGFloat {
        var randoms = [CGFloat]()
        
        for range in ranges {
            randoms.append(CGFloat.random(in: range))
        }
        
        let random = randoms[Int.random(in: 0..<randoms.count)]
        
        return random
    }
}
