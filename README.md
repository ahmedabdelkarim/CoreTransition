# CoreTransition
iOS framework for impressive transition animations between views. Built using Swift, and supports a lot of animations to navigate to a view or back to the first view.

[![license](https://img.shields.io/badge/license-MIT-black)](https://github.com/ahmedabdelkarim/CoreTransition)
[![Xcode Version](https://img.shields.io/badge/Xcode-12.3%2B-blue)](https://github.com/ahmedabdelkarim/CoreTransition)
[![iOS Version](https://img.shields.io/badge/iOS-14.3%2B-blue)](https://github.com/ahmedabdelkarim/CoreTransition)
[![Swift Version](https://img.shields.io/badge/Swift-5.0%2B-orange)](https://github.com/ahmedabdelkarim/CoreTransition)

# Video Demo

https://user-images.githubusercontent.com/8017394/181863182-988404a1-6f16-4938-8ded-1ad347271434.MP4

# Supported Transitions
* Fade
* Zoom
* Cover
* Slide
* Curtain
* Curtain Zoom
* Door
* Window
* Puzzle Board
* Morph
* Matched Morph (In progress)

# Prerequisites
* macOS Big Sur, or later
* Xcode 12.3+
* Simulator or iPhone device with iOS 14.3+

# Install CoreTransition (using CocoaPods)
1. Make sure you have CocoaPods installed.
2. Update local pod repo using command `pod repo update` or `pod repo update trunk`.
3. Open Terminal from your project folder, and run commad `pod init`.
4. Add `pod 'CoreTransition'` inside Podfile, and run `pod install`.
5. Use the framework like the code below, and call `dismiss(animated: true)` in the preseted view.

# Code Example
```swift
import UIKit
import CoreTransition

class ViewController: UIViewController {
    // MARK: - Properties
    let transitionManager = CTTransitionManager()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Present the other view wherever suitable in code
        applyTransition()
    }
    
    // MARK: - Methods
    func applyTransition() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PresentedViewController") as! PresentedViewController
        
        // Present vc with fade transition animation
        // Change style and duration to get another awesome transition
        transitionManager.transition(from: self, to: vc, style: .fade, duration: 1)
    }
}
```

To present a `UIViewController` using one of supported transitions but dismiss it in your own way, call transition with inline object of `CTTransitionManager` like this:

```swift
CTTransitionManager().transition(from: self, to: vc, style: .fade)
```
