//
//  MMNinePageController.swift
//  Mall
//
//  Created by iOS on 2022/4/21.
//

import UIKit
import JXSegmentedView

class MMNinePageController: UIViewController {

    convenience init(itemModel: MMNineCateItemModel) {
        self.init(nibName: nil, bundle: nil)
        self.currItemModel = itemModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    private var currItemModel = MMNineCateItemModel()

}


extension MMNinePageController: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return self.view
    }
    
}
