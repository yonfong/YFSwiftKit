//
//  ColorExtension.swift
//  YFSwiftKit
//
//  Created by sky on 2022/10/8.
//


import UIKit

public extension UIColor {
    static func dynamicColor(defaultColor: UIColor, darkColor: UIColor?) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return darkColor ?? defaultColor
                }
                return defaultColor
            }
        } else {
            return defaultColor
        }
    }
    
    /// Default count limit: 100
    class var cacheCountLimit: Int {
        set {
            hexColorCache.countLimit = newValue
        }
        get {
            return hexColorCache.countLimit
        }
    }
    
    private class func hexToUInt64(_ hexString: String) -> UInt64 {
        var result: UInt64 = 0
        guard Scanner(string: hexString).scanHexInt64(&result) else {
            return 1
        }
        return result
    }
    
    private static var hexColorCache: NSCache<NSString, UIColor> = {
        let cache = NSCache<NSString, UIColor>()
        cache.countLimit = 100;
        return cache
    }()
        
    class func hexColor(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        
        var resultHex = hexString
        
        if hexString.hasPrefix("#") {
            resultHex.removeFirst(1)
        }
        
        var resultAlpha: CGFloat = alpha
        if resultHex.count == 8 {
            resultAlpha = CGFloat(self.hexToUInt64("0x\(resultHex.prefix(2))")) / 255.0
            resultHex.removeFirst(2)
        }
        
        if resultHex.count != 6 {
#if DEBUG
            assert(false, "Hex: [\(hexString)] format is error!")
#endif
            return self.clear
        }
        
        // hex color from cache
        if let cacheColor = self.hexColorCache.object(forKey: resultHex as NSString) {
            return cacheColor.withAlphaComponent(resultAlpha)
        }
        
        // get green hex index
        let greenBegin = resultHex.index(resultHex.startIndex, offsetBy: 2)
        let greenEnd = resultHex.index(resultHex.startIndex, offsetBy: 3)
        
        let red = CGFloat(self.hexToUInt64("0x\(resultHex.prefix(2))")) / 255.0
        let green = CGFloat(self.hexToUInt64("0x\(resultHex[greenBegin...greenEnd])")) / 255.0
        let blue = CGFloat(self.hexToUInt64("0x\(resultHex.suffix(2))")) / 255.0
        
        var resultColor: UIColor
        
        #if os(iOS) || os(watchOS) || os(tvOS)
          resultColor = self.init(red:red, green:green, blue:blue, alpha:resultAlpha)
        #else
          resultColor = self.init(calibratedRed:red, green:green, blue:blue, alpha:resultAlpha)
        #endif
        
        self.hexColorCache.setObject(resultColor, forKey: hexString as NSString)
        
        return resultColor
    }
}





