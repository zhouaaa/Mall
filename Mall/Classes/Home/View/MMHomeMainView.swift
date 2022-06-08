//
//  MMHomeMainView.swift
//  Mall
//
//  Created by iOS on 2022/4/11.
//

import UIKit
import YYKit


protocol MMHomeMainViewDelegate {
    func homeMainViewCollectionView(_ collectionView: MMHomeMenusView, didSelectItemAt indexPath: IndexPath)
}


class MMHomeMainView: UIView {

    public var delegate: MMHomeMainViewDelegate!
    
    private var menuHeight: CGFloat {
        get {
            let cellHeight = (kScreenWidth - STtrans(24)) * (62.4/184.6)
            return CGFloat(cellHeight + STtrans(28))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.hexColor(0xf6f6f6)
        
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
        
        self.addSubview(self.marqueeView)
        self.marqueeView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(STtrans(12))
            make.right.equalTo(self.snp.right).offset(-STtrans(12))
            make.top.equalTo(self.menuView.snp.bottom).offset(STtrans(12))
            make.height.equalTo(STtrans(50))
        }
        
        
        self.addSubview(self.rankView)
        self.rankView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(STtrans(12))
            make.right.equalTo(self.snp.centerX).offset(-STtrans(3))
            make.top.equalTo(self.marqueeView.snp.bottom).offset(STtrans(6))
            make.bottom.equalTo(self.snp.bottom).offset(-STtrans(6))
        }
        
        
        self.addSubview(self.spikeView)
        self.spikeView.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-STtrans(12))
            make.left.equalTo(self.snp.centerX).offset(STtrans(3))
            make.top.bottom.equalTo(self.rankView)
        }
        
    }
    
    private func bindUI() {
        
    }
    
    
    func reloadMenuData(listData: [MMHomeIconBannerModel]) {
        
        self.menuView.reloadMenuColllectionView(lists: listData)
        
    }
    
    func reloadMarqueeBannerData(listData: [MMPreferentMainModel]) {
        self.marqueeView.reloaCellItemMarqueData(itemList: listData)
    }
    
    /// 排行榜数据
    func reloadRankListsData(listData: [MMHomeRankModel]) {
        self.rankView.reloadHomeRankViewList(lists: listData)
    }
    
    private lazy var menuView: MMHomeMenusView = {
        let _v = MMHomeMenusView()
        _v.delegate = self
        return _v
    }()
           
    private lazy var marqueeView: MMHomeMarqueeView = {
        let _v = MMHomeMarqueeView()
        return _v
    }()
    
    private lazy var rankView: MMHomeRankView = {
        let _v = MMHomeRankView()
        _v.backgroundColor = UIColor.white
        _v.layer(radius: STtrans(6), borderWidth: 0.00, borderColor: UIColor.white)
        return _v
    }()
    
    private lazy var spikeView: MMHomeSpikeView = {
        let _v = MMHomeSpikeView()
        _v.backgroundColor = UIColor.white
        _v.layer(radius: STtrans(6), borderWidth: 0.00, borderColor: UIColor.white)
        return _v
    }()
    
    
}


                                 
                            
extension MMHomeMainView: MMHomeMenusViewDelegate {

    func collectionView(_ collectionView: MMHomeMenusView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.homeMainViewCollectionView(collectionView, didSelectItemAt: indexPath)
    }
}
