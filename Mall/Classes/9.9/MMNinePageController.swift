//
//  MMNinePageController.swift
//  Mall
//
//  Created by iOS on 2022/4/21.
//

import UIKit
import JXSegmentedView
import SwiftyJSON

class MMNinePageController: MMBaseViewController {

    convenience init(itemModel: MMNineCateItemModel) {
        self.init(nibName: nil, bundle: nil)
        self.currItemModel = itemModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func setupUI() {
        
        self.view.backgroundColor = .clear
        
        if self.currItemModel.navList?.count ?? 0 > 0 {
            var titleStringLists = ["全部"]
            self.currItemModel.navList?.forEach({ (val) in
                titleStringLists.append(val.title ?? "")
            })
            self.dataSource.titles = titleStringLists
    
            self.view.addSubview(self.segmentedView)
            self.segmentedView.snp.makeConstraints { (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(44)
            }
            
            self.view.addSubview(self.collectionView)
            self.collectionView.snp.makeConstraints { (make) in
                make.top.equalTo(self.segmentedView.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            }
        }
        else
        {
            self.view.addSubview(self.collectionView)
            self.collectionView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
        
    }
    
    
    override func bind() {
        
        self.collectionView.MMHead = RefreshHeader{ [weak self] in
            guard self != nil else { return }
            self?.currentPage = 1
            self?.handleLoadPageData()
        }
        
        self.collectionView.MMFoot = RefreshFooter{ [weak self] in
            guard self != nil else { return }
            self?.handleLoadPageData()
        }
        
        self.collectionView.MMHead?.beginRefreshing()
        
    }

    
    private func handleLoadPageData() {
        
        if !((self.currItemModel.id?.isNotBlank()) != nil) {
            return
        }
        
        var _cid = self.currItemModel.id ?? ""
        if self.currItemModel.navList?.count ?? 0 > 0 && self.segmentedView.selectedIndex > 0 {
            _cid = self.currItemModel.navList?[self.segmentedView.selectedIndex - 1].id ?? ""
        }
        
        _ = kNineApiProvider.yn_request(.NinePageGoods(cid: _cid, pageNo: self.currentPage)).subscribe(onNext: { [weak self] (json) in
            self?.collectionView.endRefreshing()
            let jsonRes = json.dictionary
            guard let _result = MMNineGoodItemListModel.deserialize(from: jsonRes?["data"] ?? json) else { return }
            
            if self?.currentPage == 1 {
                self?.dataLists.removeAll()
            }
            
            self?.dataLists.append(contentsOf: _result.lists ?? [MMNineGoodItemModel]())
            
            self?.collectionView.reloadData()
            
            if (self?.dataLists.count ?? 0) > (_result.totalCount ) {
                self?.collectionView.MMFoot?.endRefreshingWithNoMoreData()
            }
            else
            {
                self?.currentPage += 1
            }
        }, onError: { error in
            self.collectionView.endRefreshing()
            self.collectionView.reloadData()
        })
        
    }
    
    private var currItemModel = MMNineCateItemModel()

    private var dataLists = [MMNineGoodItemModel]()
    
    private var currentPage: Int = 1
    
    private lazy var flowlayout: UICollectionViewFlowLayout = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.sectionInset = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        flowlayout.minimumLineSpacing = 12
        flowlayout.minimumInteritemSpacing = 6
        return flowlayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let _v = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
        _v.showsVerticalScrollIndicator = false
        _v.showsHorizontalScrollIndicator = false
        _v.delegate = self
        _v.dataSource = self
        _v.backgroundColor = UIColor.clear
        _v.register(MMNinePageCollectionGoodCell.self, forCellWithReuseIdentifier: "MMNinePageCollectionGoodCell")
        return _v
    }()
    
    private lazy var segmentedView: JXSegmentedView = {
        let _v = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: Int(kScreenWidth), height: 44))
        _v.backgroundColor = .clear
        _v.delegate = self
        _v.isContentScrollViewClickTransitionAnimationEnabled = false
        _v.contentEdgeInsetLeft = 12
        _v.contentEdgeInsetRight = 12
        _v.dataSource = dataSource
        //配置指示器
        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.indicatorHeight = 28
        indicator.indicatorColor = UIColor.white
        indicator.indicatorCornerRadius = 14
        indicator.indicatorPosition = .center
        indicator.isIndicatorWidthSameAsItemContent = true
        indicator.indicatorWidthIncrement = 40
        _v.indicators = [indicator]
        return _v
     }()
    
    private lazy var dataSource: JXSegmentedTitleDataSource = {
      let _data = JXSegmentedTitleDataSource()
      _data.titleNormalColor = UIColor.white.withAlphaComponent(0.8)
        _data.titleSelectedColor = UIColor.hexColor(0xff7300)
      _data.titleNormalFont = UIFont.df_getCustomFontType(with: .Regular, fontSize: 14) ?? UIFont.systemFont(ofSize: 14)
      _data.titleSelectedFont = UIFont.df_getCustomFontType(with: .Regular, fontSize: 15) ?? UIFont.systemFont(ofSize: 15)
      _data.isTitleColorGradientEnabled = false
      _data.isItemSpacingAverageEnabled = false
      _data.isTitleZoomEnabled = false
      _data.itemSpacing = 10
      _data.itemWidth =  JXSegmentedViewAutomaticDimension
      _data.itemWidthIncrement = 28
      return _data
   }()
    
    
}

extension MMNinePageController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMNinePageCollectionGoodCell", for: indexPath) as! MMNinePageCollectionGoodCell
        
        if self.dataLists.count > indexPath.row {
            cell.cellItemData(itemModel: self.dataLists[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.dataLists.count > indexPath.row {
            self.navigationController?.pushViewController(MMGoodsDetailsTbController(goodId: self.dataLists[indexPath.row].goodsid ?? ""), animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.width - 36)*0.5, height: (collectionView.width - 36)*0.75)
    }
    
    
}


extension MMNinePageController: JXSegmentedListContainerViewListDelegate, JXSegmentedViewDelegate{
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        self.collectionView.MMHead?.beginRefreshing()
    }
    
    func listView() -> UIView {
        return self.view
    }
    
}
