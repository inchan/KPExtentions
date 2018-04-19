//
//  Color.swift
//  KPExtentions
//
//  Created by mg_kanginchan on 2018. 4. 16..
//  Copyright © 2018년 INCHAN KANG. All rights reserved.
//

#if os(macOS)
    import Cocoa
    public typealias Color = NSColor
#else
    import UIKit
    public typealias Color = UIColor
#endif

// MARK: - Properties
public extension Color {
    /// Random color.
    public static var random: Color {
        let r = Int(arc4random_uniform(255))
        let g = Int(arc4random_uniform(255))
        let b = Int(arc4random_uniform(255))
        return Color(red: r, green: g, blue: b)!
    }
    
    // RGB compoents
    public var rgbComponents: (red: Int, green: Int, blue: Int) {
        var components: [CGFloat] {
            let c = cgColor.components!
            if c.count == 4 {
                return c
            }
            return [c[0], c[0], c[0], c[1]]
        }
        let r = components[0]
        let g = components[1]
        let b = components[2]
        return (red: Int(r * 255.0), green: Int(g * 255.0), blue: Int(b * 255.0))
    }
}

// MARK: - Methods
public extension Color {
    
    /// Create Color from RGB with alpha
    /// - Example: Color(red: 0, green: 0, blue: 0)
    public convenience init?(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }
        
        var a = alpha
        if a < 0 { a = 0 }
        if a > 1 { a = 1 }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
    /// Create Color from hex int vlaues with alpha
    /// - Example: Color(hex: 0x000000)
    public convenience init?(hex int: Int, alpha: CGFloat = 1) {
        var a = alpha
        if a < 0 { a = 0 }
        if a > 1 { a = 1 }
        
        let red = (int >> 16) & 0xff
        let green = (int >> 8) & 0xff
        let blue = int & 0xff
        self.init(red: red, green: green, blue: blue, alpha: a)
    }
    
    /// Create Color from hex string with alpha
    /// - Example: Color(hexString: 000000)
    /// - Example: Color(hexString: 0x000000)
    /// - Example: Color(hexString: 0x000000)
    /// - Example: Color(hexString: 0x000000)
    public convenience init?(hex string: String, alpha: CGFloat = 1) {
        var str = ""
        if string.lowercased().hasPrefix("0x") {
            str =  string.replacingOccurrences(of: "0x", with: "")
        } else if string.hasPrefix("#") {
            str = string.replacingOccurrences(of: "#", with: "")
        } else {
            str = string
        }
        
        if str.count == 3 { // convert hex to 6 digit format if in short format
            var newStr = ""
            str.forEach { newStr.append(String(repeating: String($0), count: 2)) }
            str = newStr
        }
        
        guard let hexValue = Int(str, radix: 16) else { return nil }
        
        var a = alpha
        if a < 0 { a = 0 }
        if a > 1 { a = 1 }
        
        self.init(red: (hexValue >> 16) & 0xff,
                  green: (hexValue >> 8) & 0xff,
                  blue: hexValue & 0xff,
                  alpha: a)
    }

}
