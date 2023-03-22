//
//  UIView+Extensions.swift
//  CoreTransition
//
//  Created by Ahmed Abdelkarim.
//

import UIKit

private struct AssociatedKeys {
    static var morphId = "morphId"
    static var finalAffineTransform = "finalAffineTransform"
}

extension UIView {
    // MARK: - Attributes
    @IBInspectable var morphId: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.morphId) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.morphId, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var finalAffineTransform: CGAffineTransform? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.finalAffineTransform) as? CGAffineTransform
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.finalAffineTransform, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Methods
    func getScreenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        self.drawHierarchy(in: self.frame, afterScreenUpdates: true)
        let screenshotImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return screenshotImage
    }
    
    func getHorizontalHalfImages() -> (leftHalfImage: UIImage?, leftHalfFrame: CGRect, rightHalfImage: UIImage?, rightHalfFrame: CGRect) {
        // prepare each half frame
        let leftHalfFrame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.width / 2, height: self.frame.height))
        let rightHalfFrame = CGRect(origin: CGPoint(x: self.frame.width / 2, y: self.frame.origin.y), size: CGSize(width: self.frame.width / 2, height: self.frame.height))
        
        // take screenshot of view
        let screenshotImage = self.getScreenshot()
        
        // crop image to left & right half
        var leftHalfImage: UIImage?
        var rightHalfImage: UIImage?
        
        var leftHalfRect = leftHalfFrame
        leftHalfRect.size.width *= screenshotImage.scale
        leftHalfRect.size.height *= screenshotImage.scale
        
        if let croppedCGImage = screenshotImage.cgImage?.cropping(to: leftHalfRect) {
            leftHalfImage = UIImage(cgImage: croppedCGImage)
        }
        
        var rightHalfRect = rightHalfFrame
        rightHalfRect.origin.x *= screenshotImage.scale
        rightHalfRect.size.width *= screenshotImage.scale
        rightHalfRect.size.height *= screenshotImage.scale
        
        if let croppedCGImage = screenshotImage.cgImage?.cropping(to: rightHalfRect) {
            rightHalfImage = UIImage(cgImage: croppedCGImage)
        }
        
        return (leftHalfImage, leftHalfFrame, rightHalfImage, rightHalfFrame)
    }

    func getVerticalHalfImages() -> (topHalfImage: UIImage?, topHalfFrame: CGRect, bottomHalfImage: UIImage?, bottomHalfFrame: CGRect) {
        // prepare each half frame
        let topHalfFrame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.width, height: self.frame.height / 2))
        let bottomHalfFrame = CGRect(origin: CGPoint(x: self.frame.origin.x, y: self.frame.height / 2), size: CGSize(width: self.frame.width, height: self.frame.height / 2))
        
        // take screenshot of view
        let screenshotImage = self.getScreenshot()
        
        // crop image to top & bottom half
        var topHalfImage: UIImage?
        var bottomHalfImage: UIImage?
        
        var topHalfRect = topHalfFrame
        topHalfRect.size.width *= screenshotImage.scale
        topHalfRect.size.height *= screenshotImage.scale
        
        if let croppedCGImage = screenshotImage.cgImage?.cropping(to: topHalfRect) {
            topHalfImage = UIImage(cgImage: croppedCGImage)
        }
        
        var bottomHalfRect = bottomHalfFrame
        bottomHalfRect.origin.y *= screenshotImage.scale
        bottomHalfRect.size.width *= screenshotImage.scale
        bottomHalfRect.size.height *= screenshotImage.scale
        
        if let croppedCGImage = screenshotImage.cgImage?.cropping(to: bottomHalfRect) {
            bottomHalfImage = UIImage(cgImage: croppedCGImage)
        }
        
        return (topHalfImage, topHalfFrame, bottomHalfImage, bottomHalfFrame)
    }
    
    
    struct CTImagePortion {
        let frame: CGRect
        let image: UIImage?
    }
    
    func getImagePortions(rows: Int, columns: Int) -> Array<[CTImagePortion]> {
        // prepare dimensions of portions
        let portionWidth = self.frame.width / CGFloat(columns)
        let portionHeight = self.frame.height / CGFloat(rows)
        let portionSize = CGSize(width: portionWidth, height: portionHeight)
        
        // take screenshot of view
        let screenshotImage = self.getScreenshot()
        
        // prepare portions by calculating frames & cropping images
        var portions = Array<[CTImagePortion]>()
        
        for row in 0..<rows {
            var rowPortions = [CTImagePortion]()
            
            for column in 0..<columns {
                let x = portionWidth * CGFloat(column)
                let y = portionHeight * CGFloat(row)
                
                let portionOrigin = CGPoint(x: x, y: y)
                
                let portionFrame = CGRect(origin: portionOrigin, size: portionSize)
                var imageScaledPortionFrame = portionFrame
                imageScaledPortionFrame.origin.x *= screenshotImage.scale
                imageScaledPortionFrame.origin.y *= screenshotImage.scale
                imageScaledPortionFrame.size.width *= screenshotImage.scale
                imageScaledPortionFrame.size.height *= screenshotImage.scale
                
                if let portionImage = screenshotImage.cgImage?.cropping(to: imageScaledPortionFrame) {
                    rowPortions.append(CTImagePortion(frame: portionFrame, image: UIImage(cgImage: portionImage)))
                }
                else {
                    rowPortions.append(CTImagePortion(frame: portionFrame, image: nil))
                }
            }
            
            portions.append(rowPortions)
        }
        
        return portions
    }
}
