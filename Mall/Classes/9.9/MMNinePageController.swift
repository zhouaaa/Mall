//
//  MMNinePageController.swift
//  Mall
//
//  Created by iOS on 2022/4/21.
//

import UIKit
import JXSegmentedView

class MMNinePageController: MMBaseViewController {

    convenience init(itemModel: MMNineCateItemModel) {
        self.init(nibName: nil, bundle: nil)
        self.currItemModel = itemModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func setupUI() {
        
    }
    
    override func bind() {
        
    }

    
    private var currItemModel = MMNineCateItemModel()

}


extension MMNinePageController: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return self.view
    }
    
}
