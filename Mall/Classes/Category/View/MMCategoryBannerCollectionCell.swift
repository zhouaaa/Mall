//
//  MMCategoryBannerCollectionCell.swift
//  Mall
//
//  Created by iOS on 2022/4/2.
//

import UIKit
import SDCycleScrollView


class MMCategoryBannerCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.markUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func markUI() {
        
        self.contentView.addSubview(self.bannerView)
        self.bannerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func reloadTbDetailBannerData(list:String) {
        let lists = list.components(separatedBy: ",")
        if lists.count > 0 {
            self.bannerView.imageURLStringsGroup = lists
        }
    }
    
    private lazy var bannerView: SDCycleScrollView = {
        let _v = SDCycleScrollView(frame: CGRect.zero, delegate: self, placeholderImage: kGlobalDefultImage)
        _v?.backgroundColor = UIColor.white
        _v?.pageDotColor = UIColor.hexColor(0x999999)
        _v?.currentPageDotColor = UIColor.hexColor(0xf21724)
        return _v!
    }()
    
}

extension MMCategoryBannerCollectionCell: SDCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
    }
}
