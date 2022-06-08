//
//  MMHomePageBannerCollectionCell.swift
//  Mall
//
//  Created by iOS on 2022/5/26.
//

import UIKit
import SDCycleScrollView

class MMHomePageBannerCollectionCell: UICollectionViewCell, SDCycleScrollViewDelegate {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer(radius: 6, borderWidth: 0.0, borderColor: UIColor.white)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        let cellWidth = (kScreenWidth - STtrans(36))*0.5
        self.bannerView.infiniteLoop = true
        self.bannerView.autoScrollTimeInterval = 3
        self.bannerView.autoScroll  = true
        self.bannerView.pageDotColor = UIColor.white
        self.bannerView.currentPageDotColor = UIColor.hexColor(0xee0a24)
        self.contentView.addSubview(self.bannerView)
        self.bannerView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.width.equalTo(floor(cellWidth))
        }
    }
    
    func setRecomBannerItem(list: [MMHomeIconBannerModel]) {
        let listUrls = list.compactMap({$0.img})
        self.bannerView.imageURLStringsGroup = listUrls
    }
    
    private lazy var bannerView: SDCycleScrollView = {
        let _bannerView = SDCycleScrollView(frame: CGRect.zero, delegate: self, placeholderImage: kGlobalDefultImage)
        _bannerView?.backgroundColor = UIColor.white
        _bannerView?.layer(radius: 8, borderWidth: 0.0, borderColor: UIColor.white)
        return _bannerView!
    }()
    
}
