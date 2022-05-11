//
//  MMNineRecomController.swift
//  Mall
//
//  Created by iOS on 2022/4/21.
//

import UIKit
import JXSegmentedView
import YYKit

class MMNineRecomController: MMBaseViewController {

    convenience init(itemModel: MMNineCateItemModel) {
        self.init(nibName: nil, bundle: nil)
        self.currItemModel = itemModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    
    override func setupUI() {
        
        if ((self.currItemModel.id?.isNotBlank()) != nil)  {
            _ = kNineApiProvider.yn_request(.NinePageGoods(cid: self.currItemModel.id ?? "", pageNo: self.currentPage)).subscribe(onNext: { (json) in
                NSLog("----------\(json)")
            }, onError: { error in
                
            })
        }
        
    }

    override func bind() {
            
    }
    
    
    
    private var currItemModel = MMNineCateItemModel()
    private var currentPage: Int = 1
}

extension MMNineRecomController: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return self.view
    }
    
}
