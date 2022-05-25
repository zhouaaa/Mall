//
//  MMBaseViewController.swift
//  Mall
//
//  Created by iOS on 2022/5/11.
//

import UIKit

class MMBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.hx_shadowHidden = true
        self.view.backgroundColor = UIColor.hexColor(0xF5F7FA)
        
        self.setupUI()
        self.bind()
        
        //四周均不延伸
        self.edgesForExtendedLayout = []
    }
    

    func setupUI() {
        
    }
    
    func bind() {
        
    }
    
    func setNavBackWhiteOrBlack(isBlack: Bool = true) {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: isBlack ? "NavBack_Black" : "NavBack_White"), for: .normal)
        button.setImage(UIImage.init(named: isBlack ? "NavBack_Black" : "NavBack_White"), for: .selected)
        button.setImage(UIImage.init(named: isBlack ? "NavBack_Black" : "NavBack_White"), for: .highlighted)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }

    @objc private func backAction() {
        if let navigationController = self.navigationController {
            if navigationController.viewControllers.count > 1 {
                navigationController.popViewController(animated: true)
                return
            }
        }
        self.dismiss(animated: true, completion: nil)
    }

    
}
