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
    

    public var delegate: MMHomeMenusViewDelegate!
    
    private var menuListsModel = [MMHomeIconBannerModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        self.addSubview(self.menuCollectionView)
        menuCollectionView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(STtrans(12))
            make.right.equalTo(self.snp.right).offset(-STtrans(12))
            make.top.bottom.equalToSuperview()
        }
    
        self.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.menuCollectionView.snp.bottom)
            make.left.equalTo(self.menuCollectionView.snp.left).offset(20)
            make.right.equalTo(self.menuCollectionView.snp.right).offset(-20)
            make.height.equalTo(STtrans(10))
        }
        
    }
    
    func reloadMenuColllectionView(lists:[MMHomeIconBannerModel]) {
       
        self.menuListsModel = lists
        self.menuCollectionView.reloadData()
        
        self.backgroundColor = UIColor.hexRGBAColor(MMHomeConfigService.shared.homeConfig.styles?.icons?.bg_color ?? "rgba(255,255,255,1)")
        
        let _count = lists.count
        self.pageControl.numberOfPages = Int(ceilf(Float(_count)/10))
        self.pageControl.currentPage = 0
        self.pageControl.isHidden = _count < 10
//        self.menuCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
    
    }
    
    private lazy var menuCollectionView: UICollectionView = {
        let layout = MMHorizontalPageLayout()
        layout.itemCountPerRow = 5
        layout.rowCount = 2
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
        _v.register(MMHomeMenusCollectionCell.self, forCellWithReuseIdentifier: MMHomeMenusCollectionCell.reuseId)
        return _v
    }()
    
    
    private lazy var pageControl: UIPageControl = {
        let _v = UIPageControl()
        _v.pageIndicatorTintColor = UIColor.hexColor(0x333333)
        _v.currentPageIndicatorTintColor = UIColor.hexColor(0xf21724)
        return _v
    }()
}


extension MMHomeMenusView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuListsModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MMHomeMenusCollectionCell.reuseId, for: indexPath) as! MMHomeMenusCollectionCell
        
        if indexPath.row < self.menuListsModel.count {
            cell.setMenuCellData(cellData: self.menuListsModel[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.collectionView(self, didSelectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.width*0.2
        return CGSize(width: cellWidth, height: cellWidth*(62.4/73.84))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: STtrans(6), left: 0, bottom: STtrans(18), right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let page = Int(ceilf(Float(scrollView.contentOffset.x/self.menuCollectionView.width)))
            if (page > self.pageControl.numberOfPages) {
                self.pageControl.currentPage = (self.pageControl.numberOfPages - 1)
            } else {
                self.pageControl.currentPage = page
            }
        }
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
            //make.width.height.equalTo(self.contentView.snp.width).multipliedBy(52.0/73.84)
            make.width.height.equalTo(STtrans(52))
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
        self.titleLabel.textColor = MMHomeConfigService.shared.homeConfig.styles?.icons?.font_color?.count ?? 0 > 0 ? UIColor.hexRGBAColor(MMHomeConfigService.shared.homeConfig.styles?.icons?.font_color ?? "") : UIColor.hexColor(0x333333)
    }
    
    private lazy var iconImageV: UIImageView = {
        let _v = UIImageView()
        _v.contentMode = .scaleAspectFit
        _v.image = kGlobalDefultImage
        return _v
    }()
    
    private lazy var titleLabel: UILabel = {
        let _lab = UILabel()
        _lab.font = UIFont.df_getCustomFontType(with: .DefaultFont, fontSize: 10)
        _lab.textAlignment = .center
        _lab.textColor =
        MMHomeConfigService.shared.homeConfig.styles?.icons?.font_color?.count ?? 0 > 0 ? UIColor.hexRGBAColor(MMHomeConfigService.shared.homeConfig.styles?.icons?.font_color ?? "") : UIColor.hexColor(0x333333)
        _lab.text = ""
        return _lab
    }()
}
