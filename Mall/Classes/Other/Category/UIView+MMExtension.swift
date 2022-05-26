//
//  UIView+MMExtension.swift
//  Mall
//
//  Created by iOS on 2022/4/11.
//

import Foundation
import UIKit
import RxSwift

private var tapKey: Void?

extension UIView {
    
    static var reuseId : String {
        get {
            return NSStringFromClass(self).components(separatedBy: ".").last!
        }
    }
    
    static var nib: UINib? {
        get {
            return UINib(nibName: self.reuseId, bundle: nil)
        }
    }
    
    var tap: UITapGestureRecognizer! {
        get {
            if let value = objc_getAssociatedObject(self, &tapKey) as? UITapGestureRecognizer {
                return value
            } else {
                let tap: UITapGestureRecognizer = UITapGestureRecognizer()
                self.addGestureRecognizer(tap)
                self.tap = tap
                return tap
            }
        }
        set {
            objc_setAssociatedObject(self, &tapKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /*
    /// 扩展 view 的点击手势事件回调
    public func performWhenTap(action: @escaping ()->Void) {
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
       
        _ = tap.rx.event.subscribe(onNext: { tap in
            action()
        })
    }
     */
    
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
