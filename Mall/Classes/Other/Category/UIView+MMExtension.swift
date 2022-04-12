//
//  UIView+MMExtension.swift
//  Mall
//
//  Created by iOS on 2022/4/11.
//

import Foundation
import UIKit

extension UIView {
    
    /// 移动到指定中心点位置
    func moveToPoint(point:CGPoint) -> Void {
    
        var center = self.center
    
        center.x = point.x
    
        center.y = point.y
    
        self.center = center
    }
    
    

    /// 缩放到指定大小
    func scaleToSize(scale:CGFloat) -> Void {
    
        var rect = self.frame
     
        rect.size.width *= scale
     
        rect.size.height *= scale
     
        self.frame = rect
    }
    
    // MARK: - 毛玻璃效果
    // 毛玻璃
    func effectViewWithAlpha(alpha:CGFloat) -> Void {
    
        let effect = UIBlurEffect.init(style: UIBlurEffect.Style.light)
     
        let effectView = UIVisualEffectView.init(effect: effect)
     
        effectView.frame = self.bounds
     
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
    
    // MARK: - 边框属性
    // 圆角边框设置
    func layer(radius:CGFloat, borderWidth:CGFloat, borderColor:UIColor) -> Void
    {
        if (0.0 < radius)
        {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
            self.clipsToBounds = true
        }
        
        if (0.0 < borderWidth)
        {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
        }
    }
    
    // MARK: - 翻转
    // 旋转 旋转180度 M_PI
    func viewTransformWithRotation(rotation:CGFloat) -> Void
    {
        self.transform = CGAffineTransform(rotationAngle: rotation);
    }
    
    // 缩放
    func viewScaleWithSize(size:CGFloat) -> Void
    {
        self.transform = self.transform.scaledBy(x: size, y: size);
    }
    
    // 水平，或垂直翻转
    func viewFlip(isHorizontal:Bool) -> Void
    {
        if (isHorizontal)
        {
            // 水平
            self.transform = self.transform.scaledBy(x: -1.0, y: 1.0);
        }
        else
        {
            // 垂直
            self.transform = self.transform.scaledBy(x: 1.0, y: -1.0);
        }
    }
    
}
