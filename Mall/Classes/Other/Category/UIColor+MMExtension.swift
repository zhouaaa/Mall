//
//  UIColor+MMExtension.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import Foundation
import UIKit

extension UIColor {
    
    /// 适配深色模式 浅色模式 非layer
    /// - Parameters:
    ///   - lightColor: 浅色模式的颜色（UIColor）
    ///   - darkColor: 深色模式的颜色（UIColor）
    /// - Returns: description
    static func dynamicColor(_ lightColor: UIColor, darkColor: UIColor)  -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (traitCollection) in
                if traitCollection.userInterfaceStyle == .dark {
                    return darkColor
                }
                else
                {
                    return lightColor
                }
            }
        }
        else
        {
            return lightColor
        }
    }
    
    static func hexColor(_ hexValue: Int) -> UIColor {
        return UIColor(red: (CGFloat)((hexValue & 0xFF0000) >> 16) / 255.0, green: (CGFloat)((hexValue & 0xFF00) >> 8) / 255.0, blue: (CGFloat)(hexValue & 0xFF) / 255.0, alpha: 1.0)
    }
    
    static func hexColor(_ hexValue: Int, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: (CGFloat)((hexValue & 0xFF0000) >> 16) / 255.0, green: (CGFloat)((hexValue & 0xFF00) >> 8) / 255.0, blue: (CGFloat)(hexValue & 0xFF) / 255.0, alpha: alpha)
    }
    
}


/**字体类型*/
enum CustomFontType : Int {
    //默认Regular
    case DefaultFont
    case Ultralight
    case Thin
    case Light
    case Regular
    case Medium
    case Semibold
}

extension UIFont {
    
    class func df_getCustomFontType(with stringTypeName: CustomFontType, fontSize size: CGFloat) -> UIFont? {
            var stringType = ""
        switch stringTypeName {
        case .Regular:
            stringType = IOS9 ? "PingFangSC-Regular":"Helvetica"
        case .Medium:
            stringType = IOS9 ? "PingFangSC-Medium":"Helvetica-Bold"
        case .Semibold:
            stringType = IOS9 ? "PingFangSC-Semibold":"Helvetica-Bold"
        case .Ultralight:
            stringType = IOS9 ? "PingFangSC-Ultralight":"Helvetica-Light"
        case .Thin:
            stringType = IOS9 ? "PingFangSC-Thin":"Helvetica-Light"
        case .Light:
            stringType = IOS9 ? "PingFangSC-Light":"Helvetica"
        case .DefaultFont:
            fallthrough
        default:
            break
        }
        
        if (stringType == "") {
             return UIFont.systemFont(ofSize: size)
            }
        else {
            return UIFont(name: stringType, size: size)
        }
    }
}


extension Int {
    func formatUsingAbbrevation () -> String {
        let abbrev = "万BTPE"
        return abbrev.enumerated().reversed().reduce(nil as String?) { accum, tuple in
            let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 4)
            let format = (factor.truncatingRemainder(dividingBy: 1)  == 0 ? "%.0f%@" : "%.1f%@")
            return accum ?? (factor > 1 ? String(format: format, factor, String(tuple.1)) : nil)
        } ?? String(self)
    }
}
