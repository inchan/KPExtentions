//
//  UIScrollView.swift
//  KPExtentions
//
//  Created by mg_kanginchan on 2018. 4. 19..
//  Copyright © 2018년 INCHAN KANG. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    /// Scroll to bottom of ScrollView.
    /// - Parameter animated: set true to animate scroll (default is true).
    public func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    /// Scroll to top of ScrollView.
    /// - Parameter animated: set true to animate scroll (default is true).
    public func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
}
