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

}
