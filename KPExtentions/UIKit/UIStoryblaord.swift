//
//  UIStoryblaord.swift
//  KPExtentions
//
//  Created by mg_kanginchan on 2018. 4. 19..
//  Copyright © 2018년 INCHAN KANG. All rights reserved.
//

import Foundation
import UIKit

public extension UIStoryboard {
    
    /// SwifterSwift: Get main storyboard for application
    public static var mainStoryboard: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else { return nil }
        return UIStoryboard(name: name, bundle: bundle)
    }
    
    /// SwifterSwift: Instantiate a UIViewController using its class name
    ///
    /// - Parameter name: UIViewController type
    /// - Returns: The view controller corresponding to specified class name
    public func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: name)) as? T
    }
    
    public static func getInstanceViewController<T: UIViewController>(withClass name: T.Type) -> T? {
        for sb in UIStoryboard.allStoryboards {
            if let vc = sb.instantiateViewController(withClass: name) {
                return vc
            }
        }
        return nil
    }
    
    /// get All storyboard instance
    ///
    ///
    public static var allStoryboards: [UIStoryboard] {
        var storyboards: [UIStoryboard] = []
        guard let resourcePath = Bundle.main.resourcePath else { return storyboards }
        print(resourcePath)
        func searchFiles(startPath: String, targetExtention: String) -> [String] {
            var storyboardPaths: [String] = []
            if let cententPaths = try? FileManager.default.contentsOfDirectory(atPath: startPath) {
                cententPaths.forEach({ (cententPath) in
                    let contentFullPath = "\(startPath)/\(cententPath)"
                    if let extention = cententPath.components(separatedBy: ".").last, extention == targetExtention {
                        storyboardPaths.append(contentFullPath)
                    }
                    else {
                        storyboardPaths.append(contentsOf: searchFiles(startPath: contentFullPath, targetExtention: targetExtention))
                    }
                })
            }
            return storyboardPaths
        }
        
        let storyboardPaths = searchFiles(startPath: resourcePath, targetExtention: "storyboardc")
        storyboardPaths.forEach { (storyboardPath) in
            if let sbName = storyboardPath.components(separatedBy: "/").last?.components(separatedBy: ".").first {
                storyboards.append(UIStoryboard(name: sbName, bundle: Bundle.main))
            }
        }
        return storyboards
    }
}
