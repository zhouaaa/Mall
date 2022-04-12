//
//  Constant.swift
//  Mall
//
//  Created by iOS on 2022/3/1.
//

import Foundation
import UIKit

let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width

let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height

let kSafeBottomMargin : CGFloat = (isIPhoneX ? 34 : 0)

let kNavigationBarHeight : CGFloat = isIPhoneX ? 88 : 64

let kTabBarHeight : CGFloat = isIPhoneX ? 49 + 34 : 49

let kSafeTopMargin : CGFloat = (isIPhoneX ? 24 : 0)

let screenFrame:CGRect = UIScreen.main.bounds

var isIPhoneX: Bool {
    if #available(iOS 11, *) {
        guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
            return false
        }
        if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
            debugPrint(unwrapedWindow.safeAreaInsets)
            return true
        }
    }
    return false
}

//系统版本
let kSystemVersion = UIDevice.current.systemVersion

//系统版本
let IOS9  = (Double(kSystemVersion)! >= 9.0)


public var kStatusBarHeight: CGFloat {
    
    return UIApplication.shared.statusBarFrame.height
}


//自定义调试阶段log
func NSLog(filePath: String = #file, rowCount: Int = #line) {
    #if DEBUG
    let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".Swift", with: "")
    print("-----------" + fileName + "/" + "\(rowCount)" + "\n")
    #endif
}

func NSLog<T>(_ message: T, filePath: String = #file, rowCount: Int = #line) {
    #if DEBUG
    let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".Swift", with: "")
    print("-----------" + fileName + "/" + "\(rowCount)" + " \(message)" + "\n")
    #endif
}
