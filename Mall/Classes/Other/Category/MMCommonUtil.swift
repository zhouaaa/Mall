//
//  MMCommonUtil.swift
//  Mall
//
//  Created by iOS on 2022/5/25.
//

import UIKit
import ImageIO



class MMCommonUtil: NSObject {
    
    
    static var shared: MMCommonUtil = MMCommonUtil()
    
    /// 返回图片尺寸
    /// - Parameter str: 图片地址
    /// - Returns: 图片尺寸
    public func imageSise(str: String, width:CGFloat = 0, height:CGFloat = 0) -> CGSize {
       
        if (width > 0 && height > 0) {
            return CGSize(width: width, height: height)
        }
        else
        {
            let imgUrl = str.contains(find: "https") ? URL(string: str) : URL(string: "http:\(str)")
            if (imgUrl != nil) {
              let lastPathComponent = imgUrl?.lastPathComponent.components(separatedBy: ".").first
              let splitedArray = lastPathComponent?.components(separatedBy: "_").last?.components(separatedBy: "x").compactMap {
                  NSInteger($0)
              }
                
              if splitedArray?.count == 2 {
                  return CGSize.init(width: splitedArray?.first ?? 0, height: splitedArray?.last ?? 0)
              } else {
                  // MARK: - TODO获取网路图片
                  let imageSourceRef = CGImageSourceCreateWithURL(imgUrl! as CFURL, nil)
                  var width: CGFloat = 0
                  var height: CGFloat = 0
                  if let imageSRef = imageSourceRef {
                      let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSRef, 0, nil)
                      if let imageP = imageProperties {
                          let imageDict = imageP as Dictionary
                          width = imageDict[kCGImagePropertyPixelWidth] as! CGFloat
                          height = imageDict[kCGImagePropertyPixelHeight] as! CGFloat
                      }
                  }
                  return CGSize(width: width, height: height)
              }
            } else {
              return CGSize.zero
            }
        }
   }
}
