//
//  MMBaseNavigationController.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import UIKit

class MMBaseNavigationController: HXNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true

            let button = UIButton.init(type: .custom)
            button.setImage(UIImage.init(named: "NavBack_Black"), for: .normal)
            button.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
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
