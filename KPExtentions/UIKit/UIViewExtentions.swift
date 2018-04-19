//
//  UIViewExtentions.swift
//  ICExtentions
//
//  Created by INCHAN KANG on 2018. 4. 6..
//  Copyright © 2018년 INCHAN KANG. All rights reserved.
//

import UIKit

// MARK: Nib Loader
extension UIView {
    public class func fromNib(nibName: String? = nil) -> Self {
        func fromNibHelper<T>(nibName: String?) -> T where T: UIView {
            let bundle = Bundle(for: T.self)
            let className = nibName ?? String(describing: T.self)
            return bundle.loadNibNamed(className, owner: nil, options: nil)?.first as? T ?? T()
        }
        return fromNibHelper(nibName: nibName)
    }
}

extension UIView {
    
    /// refer to the SwifterSwift
    /// SwifterSwift: Get view's parent view controller
    public var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    /// Remove All Subviews.
    public func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}

extension UIView {
    
    /// refer to the SwifterSwift
    /// SwifterSwift: Border color of view; also inspectable from Storyboard.
    @IBInspectable public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    /// refer to the SwifterSwift
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// refer to the SwifterSwift
    /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    /// refer to the SwifterSwift
    /// SwifterSwift: Fade in view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    public func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: completion)
    }
    
    /// refer to the SwifterSwift
    /// SwifterSwift: Fade out view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    public func fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: completion)
    }
}

extension UIView {
    
    // MARK: - Shot Cuts
    
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var w: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var h: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }
    
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
    
    var top: CGFloat {
        get {
            return y
        }
        set {
            y = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return x + w
        }
        set {
            x = newValue - w
        }
    }
    
    var left: CGFloat {
        get {
            return x
        }
        set {
            x = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.y + self.h
        }
        set {
            self.y = newValue - self.h
        }
    }
    
    private static let defaultDuration: TimeInterval = 0.25
    
    func moveX(x: CGFloat, animate: Bool = true, duration: TimeInterval = UIView.defaultDuration) {
        if animate {
            UIView.animate(withDuration: duration) { self.x = x }
        } else {
            self.x = x
        }
    }
    
    func moveY(y: CGFloat, animate: Bool = true, duration: TimeInterval = UIView.defaultDuration) {
        if animate {
            UIView.animate(withDuration: duration) { self.y = y }
        } else {
            self.y = y
        }
    }
    
    func changeW(w: CGFloat, animate: Bool = true, duration: TimeInterval = UIView.defaultDuration) {
        if animate {
            UIView.animate(withDuration: duration) { self.w = w }
        } else {
            self.w = w
        }
    }
    
    func changeH(h: CGFloat, animate: Bool = true, duration: TimeInterval = UIView.defaultDuration) {
        if animate {
            UIView.animate(withDuration: duration) { self.h = h }
        } else {
            self.h = h
        }
    }

}
