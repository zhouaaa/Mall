//
//  MMGoodsDetailsTbController.swift
//  Mall
//
//  Created by iOS on 2022/5/18.
//

import UIKit
import JXSegmentedView
import YYKit


class MMGoodsDetailsTbController: MMBaseViewController {
    
    convenience init(goodId: String) {
        self.init(nibName: nil, bundle: nil)
        self.currentGoodId = goodId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.hx_barAlpha = 0
        
        self.navigationItem.titleView = self.segmentView
        
    }
    

    override func setupUI() {
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func bind() {

        /// 商品数据
        _ = kCategoryApiProvider.yn_request(.getTaoBaoGoodsDetails(goodsId: self.currentGoodId)).subscribe(onNext: { [weak self] (json) in
            self?.collectionView.endRefreshing()
            
            let _model = MMCategoryPublicGoodModel.deserialize(from: json)
            self?.currentGoodModel = _model
            
            self?.detailPics = JsonUtil.jsonArrayToModel(_model?.detailPics ?? "", MMCategoryGoodDetailPicsModel.self) as! [MMCategoryGoodDetailPicsModel]
            
            UIView.performWithoutAnimation {
                self?.collectionView.reloadData()
            }
        }, onError: { [weak self] error in
            self?.collectionView.endRefreshing()
            if (error as NSError).code == 400 {
                self?.navigationController?.popViewController(animated: true)
            }
        })
        
        /// 推荐
        _ = kCategoryApiProvider.yn_request(.getTaoBaolistSimilerGoods(goodsId: self.currentGoodId)).subscribe(onNext: { [weak self] (json) in
            self?.collectionView.endRefreshing()
            let result = json.arrayValue.compactMap({MMCategoryPublicGoodModel.deserialize(from: $0)})
            
            self?.recommListData = result
            UIView.performWithoutAnimation {
                self?.collectionView.reloadData()
            }
        }, onError: { [weak self] error in
            self?.collectionView.endRefreshing()
        })
        
    }

    private var currentGoodId: String = ""
    private var currentGoodModel: MMCategoryPublicGoodModel?
    /// 图片详情数组
    private var detailPics = [MMCategoryGoodDetailPicsModel]()
    /// 推荐商品数据
    private var recommListData = [MMCategoryPublicGoodModel]()
    
    private lazy var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        let _v = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
        _v.showsVerticalScrollIndicator = false
        _v.showsHorizontalScrollIndicator = false
        _v.delegate = self
        _v.dataSource = self
        _v.backgroundColor = UIColor.clear
        _v.register(MMGoodsDetailsCollectionBannerCell.self, forCellWithReuseIdentifier: "MMGoodsDetailsCollectionBannerCell")
        _v.register(MMGoodsDetailsPriceCollectionCell.self, forCellWithReuseIdentifier: "MMGoodsDetailsPriceCollectionCell")
        _v.register(MMGoodsDetailsDesCollectionCell.self, forCellWithReuseIdentifier: "MMGoodsDetailsDesCollectionCell")
        _v.register(MMGoodsDetailsShopCollectionCell.self, forCellWithReuseIdentifier: "MMGoodsDetailsShopCollectionCell")
        
        _v.register(MMGoodsDetailsPicCollectionCell.self, forCellWithReuseIdentifier: "MMGoodsDetailsPicCollectionCell")
        _v.register(MMGoodsDetailsRecomCollectionCell.self, forCellWithReuseIdentifier: "MMGoodsDetailsRecomCollectionCell")
        _v.register(MMGoodsDetailsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MMGoodsDetailsCollectionReusableView")
        return _v
    }()
    
    private lazy var segmentView: JXSegmentedView = {
         let _v = JXSegmentedView(frame: CGRect(x: STtrans(60), y: 0, width: kScreenWidth - STtrans(120), height: 40))
         _v.contentEdgeInsetLeft = STtrans(24)
         _v.contentEdgeInsetRight = STtrans(24)
         _v.dataSource = segmentedSource
         _v.isContentScrollViewClickTransitionAnimationEnabled = true
         _v.delegate = self
        let _indicator = JXSegmentedIndicatorLineView()
        _indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        _indicator.indicatorWidthIncrement = -10
        _indicator.indicatorHeight = 4
        _indicator.indicatorCornerRadius = 2
        _indicator.verticalOffset = 3
        _indicator.lineStyle = .lengthen
        _indicator.indicatorColor = UIColor.dynamicColor(UIColor.hexColor(0xf21724), darkColor: UIColor.white)
        _indicator.indicatorPosition = .bottom
        _v.indicators = [_indicator]
        return _v
     }()
     
     private lazy var segmentedSource: JXSegmentedTitleDataSource = {
         let _segSource = JXSegmentedTitleDataSource()
         _segSource.titles = ["商品", "详情", "推荐"]
         _segSource.titleNormalColor = UIColor.hexColor(0x999999)
         _segSource.titleSelectedColor = UIColor.hexColor(0x333333)
         _segSource.titleNormalFont = UIFont.df_getCustomFontType(with: .Light, fontSize: 15) ?? UIFont.systemFont(ofSize: 15)
         _segSource.titleSelectedFont = UIFont.df_getCustomFontType(with: .Light, fontSize: 15) ?? UIFont.systemFont(ofSize: 15)
         _segSource.isItemSpacingAverageEnabled = true
         _segSource.isTitleColorGradientEnabled = true
         _segSource.itemWidth = JXSegmentedViewAutomaticDimension
         return _segSource
     }()
    
}


extension MMGoodsDetailsTbController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, JXSegmentedViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return self.detailPics.count
        case 2:
            return self.recommListData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMGoodsDetailsCollectionBannerCell", for: indexPath) as! MMGoodsDetailsCollectionBannerCell
                if self.currentGoodModel?.imgs?.count ?? 0 > 0 {
                    bannerCell.reloadTbDetailBannerData(list: self.currentGoodModel?.imgs ?? "")
                }
                return bannerCell
            } else if indexPath.row == 1 {
                let priceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMGoodsDetailsPriceCollectionCell", for: indexPath) as! MMGoodsDetailsPriceCollectionCell
                priceCell.setItemPriceModel(itemModel: self.currentGoodModel ?? MMCategoryPublicGoodModel())
                return priceCell
            }
            else if indexPath.row == 2 {
                let desCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMGoodsDetailsDesCollectionCell", for: indexPath) as! MMGoodsDetailsDesCollectionCell
                
                desCell.setdesCellData(cellItem: self.currentGoodModel?.desc ?? "")
                
                return desCell
            } else {
                let shopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMGoodsDetailsShopCollectionCell", for: indexPath) as! MMGoodsDetailsShopCollectionCell
                
                shopCell.setShopCellData(cellItem: self.currentGoodModel ?? MMCategoryPublicGoodModel())
                
                return shopCell
            }
        }
        else if indexPath.section == 1 {
            let picCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMGoodsDetailsPicCollectionCell", for: indexPath) as! MMGoodsDetailsPicCollectionCell
            if self.detailPics.count > indexPath.row {
                picCell.setDetailPic(cellImtem: self.detailPics[indexPath.row])
            }
            return picCell
        }
        else
        {
            let recomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMGoodsDetailsRecomCollectionCell", for: indexPath) as! MMGoodsDetailsRecomCollectionCell
            if indexPath.row < self.recommListData.count {
                recomCell.reloadRecomCellData(itemModel: self.recommListData[indexPath.row])
            }
            return recomCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return CGSize(width: collectionView.width, height: collectionView.width)
            }else if indexPath.row == 1 {
                return CGSize(width: collectionView.width, height: 200.0)
            } else if indexPath.row == 2 {
                return CGSize(width: collectionView.width, height: (self.currentGoodModel?.desc?.height(for: UIFont.df_getCustomFontType(with: .Regular, fontSize: 14) ?? UIFont.systemFont(ofSize: 14), width: (kScreenWidth - 48)) ?? 0) + STtrans(30) + 26)
            } else {
                return CGSize(width: collectionView.width, height: STtrans(64))
            }
        case 1:
            if detailPics.count <= 0 {
                return .zero
            } else {
                return CGSize(width: collectionView.width, height: self.detailPics[indexPath.row]._ImageHeight)
            }
        default:
            return CGSize(width: (collectionView.width - STtrans(36))*0.5, height: (collectionView.width - STtrans(36))*(155.24/184.6))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MMGoodsDetailsCollectionReusableView", for: indexPath) as! MMGoodsDetailsCollectionReusableView
            view.detailSection(indexPath: indexPath)
            return view
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 1:
            if self.detailPics.count > 0 {
                return CGSize(width: collectionView.width, height: STtrans(50))
            } else {
                return .zero
            }
        case 2:
            return CGSize(width: collectionView.width, height: STtrans(45))
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 1:
            return 0
        default:
            return STtrans(12)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 1:
            return 0
        default:
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0,1:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: STtrans(12))
        default:
            return UIEdgeInsets(top: STtrans(12), left: STtrans(12), bottom: STtrans(12), right: STtrans(12))
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let ratio = scrollView.contentOffset.y / (kScreenWidth)
        let alpha = ratio < 0.0 ? 0.0 : (ratio >= 1.0 ? 1.0 : ratio)
        self.hx_barAlpha = alpha
        
        if (!(scrollView.isTracking || scrollView.isDecelerating) || scrollView != self.collectionView) {
            return
        }
        
//        let leftRect = CGRect(x: scrollView.contentOffset.x, y: 0, width: 1, height: 100)
//        let topAttributes = self.collectionView.layoutAttributesForItem(at: T##IndexPath)
        
        
        
    }
    
    
   /// JXSegmentedViewDelegate
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        self.collectionView.setContentOffset(.zero, animated: true)
    }
    
    
}
