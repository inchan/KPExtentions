//
//  UIViewControllerExtentions.swift
//  ICExtentions
//
//  Created by INCHAN KANG on 2018. 4. 6..
//  Copyright © 2018년 INCHAN KANG. All rights reserved.
//

import UIKit

// MARK: Instance Loader
extension UIViewController {
    
    /// Nib Loader
    /// ViewControllerClassName.instanceFromNib()
    /// - Parameters:
    /// - nibName
    public class func instanceFromNib(_ nibName: String? = nil) -> Self? {
        func fromNibHelper<T>(nibName: String?) -> T? where T: UIViewController {
            let bundle = Bundle(for: T.self)
            return self.init(nibName: nibName, bundle: bundle) as? T
        }
        return fromNibHelper(nibName: nibName)
    }
    
    /// instance from storyboard
    /// ViewControllerClassName.instanceFromStoryboard()
    /// - Parameters:
    ///   - storyboardName: Storyboard to which the ViewController belongs (if nil -> search storyboard)
    /// - Returns: self instance (optional value)
    ///
    public class func instanceFromStoryboard(_ storyboardName: String? = nil) -> Self? {
        let className = String(describing: self)
        func fromStoryboardHelper<T>(_ storyboardName: String?) -> T? where T: UIViewController {
            if let sbName = storyboardName {
                let storyboard = UIStoryboard(name: sbName, bundle: Bundle(for: T.self))
                return storyboard.instantiateViewController(withIdentifier: className) as? T
            } else {
                return self.getInstanceFromStoryboard(className) as? T
            }
        }
        return fromStoryboardHelper(storyboardName)
    }
    
    /// Get an instance of a nib whose Identifier matches on the storyboard
    /// - Parameters:
    ///   - identifier: ViewController identifier
    /// - Returns: identifier UIViewController instance (optional value)
    ///
    public class func getInstanceFromStoryboard (_ identifier: String) -> UIViewController? {
        guard let resourcePath = Bundle(for: self).resourcePath else { return nil }
        let storyboardPaths: Array = UIViewController.storyboardPaths(resourcePath)
        for storyboardPath: String in storyboardPaths {
            do {
                if let storyboardContents: Array = try? FileManager.default.contentsOfDirectory(atPath: storyboardPath) {
                    if storyboardContents.filter({ $0 == identifier + ".nib"}).first != nil { // did find storyboard.
                        if let sbName: String = storyboardPath.components(separatedBy: "/").last?.components(separatedBy: ".").first {
                            let sb = UIStoryboard(name: sbName, bundle: Bundle.main)
                            return sb.instantiateViewController(withIdentifier: identifier)
                        }
                    }
                }
            }
        }
        return nil
    }
    
    /// Look in storyboards in bundles
    /// - Parameters:
    ///   - resourcePath: Begins with resource path.
    /// - Returns: All Storayboard paths
    ///
    private class func storyboardPaths(_ resourcePath: String ) -> [String] {
        var fileNames: [String] = []
        do {
            if let resourceContents: Array = try? FileManager.default.contentsOfDirectory(atPath: resourcePath) {
                for itemPath: String  in resourceContents {
                    if let fileExtention = itemPath.components(separatedBy: ".").last, fileExtention == "storyboardc" {
                        fileNames.append(resourcePath + "/" + itemPath)
                    } else {
                        let filePath: String = resourcePath + "/" + itemPath
                        var isDirectory: ObjCBool = false
                        let fileExistsAtPath: Bool = FileManager.default.fileExists(atPath: filePath, isDirectory: &isDirectory)
                        // 디렉터리고 파일이 존재하면 재귀호출
                        if isDirectory.boolValue && fileExistsAtPath {
                            let tempPaths: Array = UIViewController.storyboardPaths(filePath)
                            if tempPaths.count > 0 {
                                fileNames.append(contentsOf: tempPaths)
                            }
                        }
                    }
                }
            }
        }
        return fileNames
    }
}
