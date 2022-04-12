//
//  MMBaseNavigationController.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import UIKit

class MMBaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupNavigationBar()
        
        
//        let target = self.interactivePopGestureRecognizer?.delegate
//        let pan:UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: target!, action: Selector(("handleNavigationTransition:")))
//        pan.delegate = self
//        self.view.addGestureRecognizer(pan)
//        self.interactivePopGestureRecognizer?.isEnabled = false
    }
    

    private func setupNavigationBar() {
        
        self.navigationBar.barTintColor = UIColor.dynamicColor(UIColor.white, darkColor: UIColor.black)
        
        self.navigationBar.isTranslucent = false
        //self.extendedLayoutIncludesOpaqueBars = true
        
        self.navigationBar.tintColor = UIColor.dynamicColor(UIColor.white, darkColor: UIColor.black)

       #if swift(>=4.0)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.hexColor(0x333333) , NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
       #elseif swift(>=3.0)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.hexColor(0x333333), NSFontAttributeName: UIFont.systemFont(ofSize: 16)]
       #endif
    }

    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return self.children.count > 1
    }
    
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let button = UIButton.init(type: .custom)
            button.setImage(UIImage.init(named: "NavBack_Black"), for: .normal)
            button.frame = CGRect.init(x: -20, y: 0, width: 40, height: 40)
            button.addTarget(self, action: #selector(popViewController(animated:)), for: .touchUpInside)
            let backItem = UIBarButtonItem(customView: button)
            viewController.navigationItem.leftBarButtonItem = backItem
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    @objc public func backAction() {
        if let navigationController = navigationController {
            if navigationController.viewControllers.count > 1 {
                navigationController.popViewController(animated: true)
                return
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
}
