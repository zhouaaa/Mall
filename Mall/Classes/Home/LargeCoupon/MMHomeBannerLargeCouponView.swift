//
//  MMHomeBannerLargeCouponView.swift
//  Mall
//
//  Created by iOS on 2022/5/13.
//

import UIKit
import SDCycleScrollView

class MMHomeBannerLargeCouponView: UIView, SDCycleScrollViewDelegate {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.setupView()
    }
    
    private func setupView() {
        
        self.bannerView.infiniteLoop = true
        self.bannerView.autoScrollTimeInterval = 5
        self.bannerView.autoScroll  = true
        self.bannerView.currentPageDotColor = UIColor.white
        self.bannerView.pageDotColor = UIColor.white.withAlphaComponent(0.5)
        self.addSubview(self.bannerView)
        self.bannerView.snp.makeConstraints { (make) in
            make.left.equalTo(STtrans(12))
            make.right.equalTo(-STtrans(12))
            make.top.equalTo(STtrans(6))
            make.bottom.equalTo(-STtrans(6))
        }
        
    }
    
    func setBannerDatList(list:[MMHomeLargeCouponBannerItemConfigModel]) {
        
        let listUrls = list.compactMap({$0.pic})
        self.bannerView.imageURLStringsGroup = listUrls
    }
    
    private lazy var bannerView: SDCycleScrollView = {
        let _bannerView = SDCycleScrollView(frame: CGRect.zero, delegate: self, placeholderImage: kGlobalDefultImage)
        _bannerView?.backgroundColor = UIColor.clear
        _bannerView?.layer(radius: 8, borderWidth: 0.0, borderColor: UIColor.white)
        return _bannerView!
    }()

}
