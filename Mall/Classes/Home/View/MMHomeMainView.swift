//
//  MMHomeMainView.swift
//  Mall
//
//  Created by iOS on 2022/4/11.
//

import UIKit

class MMHomeMainView: UIView {

    private var menuHeight: CGFloat {
        get {
            return CGFloat((kScreenWidth*0.4 + 60))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.bindUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setUI() {
        
        self.addSubview(menuView)
        self.menuView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(menuHeight)
        }
        
    }
    
    private func bindUI() {
        
    }
    
    
    func reloadMenuData(listData: [MMHomeIconBannerModel]) {
        self.menuView.reloadMenuColllectionView(lists: listData)
    }
    
    private lazy var menuView: MMHomeMenusView = {
        let _v = MMHomeMenusView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: menuHeight))
        _v.delegate = self
        return _v
    }()
                                
}


                                 
                            
extension MMHomeMainView: MMHomeMenusViewDelegate {

    func collectionView(_ collectionView: MMHomeMenusView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
