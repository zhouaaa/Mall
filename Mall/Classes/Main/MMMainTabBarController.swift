//
//  MMMainTabBarController.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import UIKit
import ESTabBarController_swift

class MMMainTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.shouldHijackHandler = {
            tabbarController, viewController, index in
            return false
        }
        
        self.setupViewControllers()
        
    }
    
    
    
    private func setupViewControllers() {
        
        self.view.backgroundColor = UIColor.hexColor(0xffffff)
        
        //添加阴影
        self.tabBar.layer.shadowColor = UIColor.hexColor(0xededed).cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -5)
        self.tabBar.layer.shadowOpacity = 0.3
        
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.barTintColor = UIColor.dynamicColor( UIColor.white, darkColor: UIColor.black)
        self.tabBar.backgroundColor = UIColor.dynamicColor( UIColor.hexColor(0xffffff), darkColor: UIColor.black)
        

        let homeNavc = self.addChildController(MMHomeMainController(), norImage: "tabbar_home_nor", selectImage: "tabbar_home_sel", title: "首页")
        
        let nineNavc = self.addChildController(MMNineMainController(), norImage: "tabbar_9.9_nor", selectImage: "tabbar_9.9_sel", title: "9.9包邮")

        let preferentNavc = self.addChildController(MMPreferentMainController(), norImage: "tabbar_pre_nor", selectImage: "tabbar_pre_sel", title: "优惠线报")

        let categoryNavc = self.addChildController(MMCategoryMainController(), norImage: "tabbar_cate_nor", selectImage: "tabbar_cate_sel", title: "分类")
        
        self.viewControllers = [homeNavc, nineNavc, preferentNavc, categoryNavc]
        
    }
    
    
    private func addChildController(_ childController: UIViewController, norImage: String, selectImage: String, title: String) -> MMBaseNavigationController {
        
        let navVc = MMBaseNavigationController(rootViewController: childController)
        
        navVc.tabBarItem =  ESTabBarItem.init(MMBouncesContentView(), title: title, image: UIImage(named: norImage), selectedImage: UIImage(named: selectImage))
        
        
        childController.title = title
        
//        if childController.isKind(of: MMNineMainController.self) {
//            if let tabBarItem = childController.tabBarItem as? ESTabBarItem {
//                   tabBarItem.badgeValue = "99+"
//            }
//        }
        
        return navVc
    }

}
