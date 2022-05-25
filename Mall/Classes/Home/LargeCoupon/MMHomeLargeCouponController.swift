//
//  MMHomeLargeCouponController.swift
//  Mall
//
//  Created by iOS on 2022/5/13.
//

import UIKit
import JXPagingView
import JXSegmentedView
import RxSwift


class MMHomeLargeCouponController: MMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hx_barStyle = .black
        self.hx_backgroundColor = UIColor.hexColor(0x7112b7)
        self.hx_titleColor = UIColor.white
        self.hx_tintColor = UIColor.white
        self.navigationItem.title = "大额券热卖清单"
        self.setNavBackWhiteOrBlack(isBlack: false)
        
    }
    

    override func setupUI() {
        
        self.view.addSubview(self.bgImageV)
        self.bgImageV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        self.view.addSubview(self.listPageView)
        self.listPageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.segmentedView.contentScrollView = self.listPageView.listContainerView.scrollView
        
    }
    
    override func bind() {
        
        self.listPageView.mainTableView.MMHead = RefreshHeader{ [weak self] in
            guard self != nil else { return }
            self?.handleCouponData()
        }
        
        self.listPageView.mainTableView.MMHead?.beginRefreshing()
        
        
    }
    
    private func handleCouponData() {
        
        _ = kHomeApiProvider.yn_request(.HomeCouponColumnConf).subscribe(onNext: { [weak self] (json) in
            self?.listPageView.mainTableView.endRefreshing()
            guard let _result = MMHomeLargeCouponMenuModel.deserialize(from: json) else { return }
            self?.couponModel = _result
            
            self?.floorLists = _result.floor?.filter({$0.title?.contains("banner") == false }) ?? [MMHomeLargeCouponItemModel]()
            
            let _banners = _result.floor?.filter({$0.title?.contains("banner") == true }) ?? [MMHomeLargeCouponItemModel]()
            if _banners.count > 0 {
                self?.bannerLists = _banners[0].config?.banner ?? [MMHomeLargeCouponBannerItemConfigModel]()
            }
            
            self?.handleReloadMainUI()
            
        }, onError: { [weak self] (error) in
            self?.listPageView.mainTableView.endRefreshing()
        }).disposed(by: self.disposeBag)
        
    }
    
    private func handleReloadMainUI() {
        
        if self.floorLists.count <= 0 {
            return
        }
        var titleStringLists = [String]()
        self.floorLists.forEach { (valTab) in
            titleStringLists.append(valTab.title ?? "")
        }
        self.dataSource.titles = titleStringLists
        self.segmentedView.reloadData()
        self.listPageView.reloadData()
        
        self.bannerView.setBannerDatList(list: self.bannerLists)
        
    }
    
    private var couponModel: MMHomeLargeCouponMenuModel?
    
    /// list
    private var floorLists = [MMHomeLargeCouponItemModel]()
    
    /// 轮播图
    private var bannerLists = [MMHomeLargeCouponBannerItemConfigModel]()
    
    
    private lazy var bgImageV: UIImageView = {
        let _v = UIImageView()
        _v.image = UIImage(named: "home_coupon_bg")
        return _v
    }()
    
    private let disposeBag = DisposeBag()
    
    private var tableHeaderViewHeight: Int = Int(STtrans(146))
    
    private var headerInSectionHeight: Int = Int(49.0)

    private lazy var listPageView: JXPagingView = {
        let _v = JXPagingView(delegate: self, listContainerType: .scrollView)
        _v.mainTableView.gestureDelegate = self
        _v.mainTableView.backgroundColor = UIColor.clear
        _v.listContainerView.scrollView.backgroundColor = UIColor.clear
        return _v
    }()
    
    private lazy var dataSource: JXSegmentedTitleDataSource = {
      let _data = JXSegmentedTitleDataSource()
        _data.titleNormalColor = UIColor.hexColor(0x666666)
        _data.titleSelectedColor = UIColor.hexColor(0x7112b7)
        _data.titleNormalFont = UIFont.df_getCustomFontType(with: .Regular, fontSize: 15) ?? UIFont.systemFont(ofSize: 15)
        _data.titleSelectedFont = UIFont.df_getCustomFontType(with: .Regular, fontSize: 15) ?? UIFont.systemFont(ofSize: 15)
        _data.isItemSpacingAverageEnabled = false
        _data.isTitleColorGradientEnabled = true
        _data.itemSpacing = STtrans(24)
        _data.isItemSpacingAverageEnabled = true
      return _data
   }()

    private lazy var segmentedView: JXSegmentedView = {
        let _v = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: Int(kScreenWidth), height: headerInSectionHeight))
        _v.backgroundColor = UIColor.hexColor(0xF5F7FA)
        _v.contentEdgeInsetLeft = STtrans(24)
        _v.contentEdgeInsetRight =  STtrans(24)
        _v.dataSource = dataSource
        _v.isContentScrollViewClickTransitionAnimationEnabled = true
        _v.delegate = self
        let lineView = JXSegmentedIndicatorLineView()
        lineView.indicatorHeight = 3
        lineView.indicatorColor = UIColor.hexColor(0x7112b7)
        lineView.indicatorCornerRadius = 1.5
        _v.indicators = [lineView]
        return _v
     }()
    
    private lazy var bannerView: MMHomeBannerLargeCouponView = {
        let _v = MMHomeBannerLargeCouponView(frame: CGRect(x: 0, y: 0, width: Int(kScreenWidth), height: tableHeaderViewHeight))
        return _v
    }()
    
}

extension MMHomeLargeCouponController: JXSegmentedViewDelegate, JXPagingMainTableViewGestureDelegate, JXPagingViewDelegate {
    
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return self.tableHeaderViewHeight
    }
    
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return self.bannerView
    }
    
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return self.headerInSectionHeight
    }
    
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return self.segmentedView
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return self.dataSource.titles.count
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        if self.floorLists.count > index {
            return MMHomeCouponPageController(pageConfigModel: self.floorLists[index].config ?? MMHomeLargeCouponItemConfigModel())
        } else {
            return MMHomeCouponPageController()
        }
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        self.listPageView.listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        self.listPageView.listContainerView.didClickSelectedItem(at: index)
    }
    
    /// JXPagingMainTableViewGestureDelegate
    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // 禁止segmentedView左右滑动的时候，上下和左右都可以滚动
        if otherGestureRecognizer == segmentedView.collectionView.panGestureRecognizer {
            return false
        }
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
    
}
