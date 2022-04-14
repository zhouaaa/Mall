//
//  MMHomeMenusView.swift
//  Mall
//
//  Created by iOS on 2022/4/11.
//

import UIKit
import YYKit
import SDWebImage


protocol MMHomeMenusViewDelegate {
    func collectionView(_ collectionView: MMHomeMenusView, didSelectItemAt indexPath: IndexPath)
}

class MMHomeMenusView: UIView {
    
    private var itemWidth: CGFloat {
        get {
            return CGFloat(kScreenWidth / 5) //item 宽度
        }
    }
      
    private var itemHeight: CGFloat {
        get {
            return CGFloat(self.itemWidth + 20) //item 高度
        }
    }
    
    
    private let PageViewWidth:CGFloat = 60

    var delegate: MMHomeMenusViewDelegate!
    
    var menuListsModel = [MMHomeIconBannerModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.hexColor(0xf6f6f6)
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        self.addSubview(self.menuCollectionView)
        menuCollectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(itemHeight * 2)
        }
    
        self.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(menuCollectionView.snp.bottom)
            make.left.equalTo(self.menuCollectionView.snp.left).offset(20)
            make.right.equalTo(self.menuCollectionView.snp.right).offset(-20)
            make.height.equalTo(10)
        }
        
    }
    
    func reloadMenuColllectionView(lists:[MMHomeIconBannerModel]) {
        self.menuListsModel = lists
        self.menuCollectionView.reloadData()
        
        let _count = lists.count
        self.pageControl.numberOfPages = Int(ceilf(Float(_count / 10)))
        self.pageControl.currentPage = 0
        self.pageControl.isHidden = _count < 10
        self.menuCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        
        self.layoutSubviews()
    }
    
    private lazy var menuCollectionView: UICollectionView = {
        let layout = MMHorizontalPageLayout()
                    layout.itemCountPerRow = 5
                    layout.rowCount = 2
                    layout.minimumLineSpacing = 0
                    layout.minimumInteritemSpacing = 0
                    layout.itemSize = CGSize(width: itemWidth, height: itemHeight - 5)
                    layout.scrollDirection = .horizontal
        let _v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        _v.backgroundColor = UIColor.clear
        _v.dataSource = self
        _v.delegate = self
        _v.bounces = false
        _v.isPagingEnabled = true
        _v.alwaysBounceHorizontal = true
        _v.alwaysBounceVertical = false
        _v.showsHorizontalScrollIndicator = false
        _v.showsVerticalScrollIndicator = false
        _v.register(MMHomeMenusCollectionCell.self, forCellWithReuseIdentifier: "MMHomeMenusCollectionCell")
        return _v
    }()
    
    
    private lazy var pageControl: UIPageControl = {
        let _v = UIPageControl()
        _v.pageIndicatorTintColor = UIColor.hexColor(0x999999)
        _v.currentPageIndicatorTintColor = UIColor.hexColor(0xf21724)
        return _v
    }()
}


extension MMHomeMenusView: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuListsModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMHomeMenusCollectionCell", for: indexPath) as! MMHomeMenusCollectionCell
        
        if indexPath.row < self.menuListsModel.count {
            cell.setMenuCellData(cellData: self.menuListsModel[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.collectionView(self, didSelectItemAt: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/kScreenWidth
        pageControl.currentPage = Int(page)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        UIView.animate(withDuration: 0.1) {
//            let offset: CGPoint = scrollView.contentOffset
//
//        }
//    }
}


class MMHomeMenusCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        
        self.contentView.addSubview(self.iconImageV)
        self.iconImageV.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-10)
            make.width.height.equalTo((kScreenWidth/375.0)*52.0)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.iconImageV.snp.bottom).offset(2)
            make.left.equalTo(self.snp.left).offset(2)
            make.right.equalTo(self.snp.right).offset(2)
        }
        
    }
    
    func setMenuCellData(cellData: MMHomeIconBannerModel) {
        self.titleLabel.text = "\(cellData.title ?? "")"
        self.iconImageV.sd_setImage(with: URL(string: cellData.img ?? ""), placeholderImage: kGlobalDefultImage)
    }
    
    private lazy var iconImageV: UIImageView = {
        let _v = UIImageView()
        _v.backgroundColor = UIColor.clear
        _v.image = kGlobalDefultImage
        return _v
    }()
    
    private lazy var titleLabel: UILabel = {
        let _lab = UILabel()
        _lab.font = UIFont.df_getCustomFontType(with: .DefaultFont, fontSize: 10)
        _lab.textAlignment = .center
        _lab.textColor = UIColor.hexColor(0x333333)
        _lab.text = "--"
        return _lab
    }()
}
