//
//  MMHomeMarqueeView.swift
//  Mall
//
//  Created by iOS on 2022/5/26.
//

import UIKit
import SDCycleScrollView


class MMHomeMarqueeView: UIView, SDCycleScrollViewDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer(radius: STtrans(6), borderWidth: 0.0, borderColor: UIColor.white)
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        self.addSubview(self.iconImageV)
        self.iconImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(STtrans(12))
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(STtrans(36.38))
            make.height.equalTo(STtrans(15.59))
        }
        
   
        self.bannerView.scrollDirection = .vertical
        self.bannerView.autoScrollTimeInterval = 3.0
        self.bannerView.onlyDisplayText = true
        self.bannerView.titleLabelTextFont = UIFont.df_getCustomFontType(with: .Regular, fontSize: 14)
        self.bannerView.titleLabelTextColor = UIColor.hexColor(0x333333)
        self.bannerView.titleLabelHeight = STtrans(30)
        self.bannerView.titleLabelTextAlignment = .left
        self.bannerView.titleLabelBackgroundColor = UIColor.clear
        self.bannerView.titlesGroup = ["sfsfssgsgsgdsgdgdsgsg","1222222222"]
        self.addSubview(self.bannerView)
        self.bannerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImageV.snp.right).offset(STtrans(4))
            make.right.equalTo(self.snp.right).offset(-STtrans(12))
            make.centerY.equalTo(self.iconImageV.snp.centerY)
            make.height.equalTo(floor(STtrans(30)))
        }
        
    }
    
    func reloaCellItemMarqueData(itemList: [MMPreferentMainModel]) {
        let listContents = itemList.compactMap({$0.content})
        self.bannerView.titlesGroup = listContents
    }
    
    private lazy var iconImageV: UIImageView = {
        let _v = UIImageView()
        _v.setImageWith(URL(string: "https://cmsstaticv2.ffquan.cn/img/icon1.323c6360.png"), placeholder: kGlobalDefultImage)
        return _v
    }()
    
    private lazy var arrowImageV: UIImageView = {
        let _v = UIImageView()
        return _v
    }()
    
    private lazy var bannerView: SDCycleScrollView = {
        let _bannerView = SDCycleScrollView(frame: CGRect.zero, delegate: self, placeholderImage: UIImage())
        _bannerView?.backgroundColor = UIColor.white
        return _bannerView!
    }()

}
