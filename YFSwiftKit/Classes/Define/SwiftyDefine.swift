//
//  SwiftyDefine.swift
//  YFSwiftKit
//
//  Created by sky on 2022/10/8.
//

#if canImport(UIKit)

import UIKit

public func SwiftyDebugLog<T>(_ message: T, file: String = #file, function: String = #function, line: Int = #line) {
#if DEBUG
    debugPrint("[🔥] \((file as NSString).lastPathComponent) \(function) \(line): \(message)")
#endif
}

public struct SwiftyDefine {
    public struct App {
        @available(iOSApplicationExtension, unavailable)
        public static var keyWindow: UIWindow? {
            if #available(iOS 13, *) {
                return UIApplication.shared.windows.first { $0.isKeyWindow }
            } else {
                return UIApplication.shared.keyWindow
            }
        }
        
        public static var version: String? {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        }
        
        public static var build: String? {
            return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        }
        
        public static var name: String? {
            return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        }
    }
    
    public struct Device {
        /// is X series
        public static var isIphoneXSeries: Bool {
            let iPhoneXSeries = false
            if UIDevice.current.userInterfaceIdiom != .phone {
                return iPhoneXSeries
            }
            
            if #available(iOS 11.0, *) {
                if let keyWindow = App.keyWindow {
                    return keyWindow.safeAreaInsets.bottom > 0
                }
            }
            
            return iPhoneXSeries
        }
        
        public static var windowSafeAreaInset: UIEdgeInsets {
            var insets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            if #available(iOS 11.0, *) {
                insets = App.keyWindow?.safeAreaInsets ?? insets
            }
            return insets
        }
        
        public static var screenWidth: CGFloat {
            return UIScreen.main.bounds.width
        }
        
        public static var screenHeight: CGFloat {
            return UIScreen.main.bounds.height
        }
        
        public static var screenBounds: CGRect {
            return UIScreen.main.bounds
        }
        
        public static var screenSize: CGSize {
            return UIScreen.main.bounds.size
        }
        
        public static var sizeScale: CGFloat {
            return UIScreen.main.scale
        }
        
        public static var pixelLineHeight: CGFloat {
            return 1.0/sizeScale
        }
        
        public static var navigationHeight: CGFloat {
            return isIphoneXSeries == true ? 88 : 64
        }
        
        public static let safeAreaTop = windowSafeAreaInset.top == 0 ? 20 : windowSafeAreaInset.top
        public static let safeAreaBottom = windowSafeAreaInset.bottom
        public static let statusBarHeight = windowSafeAreaInset.top
        
        /// iOS 13 present 风格出来的导航条高度
        public static let navigationSmallHeight:CGFloat = 44
        public static let navBarHeight = navigationSmallHeight + statusBarHeight
        public static let toolBarHeight:CGFloat = 49
        public static let tabbarHeight = toolBarHeight + safeAreaBottom
        public static let homeIndicatorHeight = safeAreaBottom
        
        /// Device Name
        public static var deviceName: String {
            return UIDevice.current.name
        }
        
        public static var systemName: String {
            return UIDevice.current.systemName
        }
        
        public static var systemVersion: String {
            return UIDevice.current.systemVersion
        }
        
        /// isSimulator
        public static var isSimulator: Bool {
#if arch(i386) || arch(x86_64)
            return true
            #else
            return false
#endif
        }
        
        /// 当前语言
        public static var language: String {
            return Locale.current.identifier
        }
        
        /// 根据当前语言获取地区
        public static var locale: Locale {
            return Locale(identifier: language)
        }
        
        public static var country: String {
            return Locale.current.identifier
        }
        
        /// 当前设备类型 iphone ipad mac
        public enum Devicetype {
            case iPhone
            case iPad
            case Mac
        }
        
        public static var deviceType: Devicetype {
#if os(macOS)
            return .Mac
#else
            if  UIDevice.current.userInterfaceIdiom == .pad {
                return .iPad
            } else {
                return .iPhone
            }
#endif
        }
    }
}

#endif

