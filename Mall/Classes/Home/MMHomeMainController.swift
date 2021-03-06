//
//  MMHomeMainController.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import UIKit
import JXPagingView
import JXSegmentedView

class MMHomeMainController: MMBaseViewController, MMHomeMainViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = ""
        self.hx_barStyle = .black
        
        
    }
    
    
    override func setupUI() {
        
        self.view.addSubview(self.listPageView)
        self.listPageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.segmentedView.contentScrollView = self.listPageView.listContainerView.scrollView
        
    }
    override func bind() {
        
        self.listPageView.mainTableView.MMHead = RefreshHeader{ [weak self] in
            guard self != nil else { return }
            self?.handleHomeMainData()
        }
        
        self.listPageView.mainTableView.MMHead?.beginRefreshing()
        
    }

    
    private func handleHomeMainData() {
        
        
        _ = kHomeApiProvider.yn_request(.HomeCmsV2Ads(siteId:"369616", temp_id: "2", page: 1)).subscribe(onNext: { [weak self] (json) in
            self?.listPageView.mainTableView.endRefreshing()
            
            let result = MMHomeMainModel.deserialize(from: json) ?? MMHomeMainModel()
            MMHomeConfigService.shared.handleSubscribeHomeConfig(json: result)
            
            self?.hx_backgroundColor = UIColor.hexRGBAColor(result.styles?.top_entrance?.bg_color ?? "rgba(255,255,255,1)")
            
            /// 首页菜单
            var menu = [MMHomeIconBannerModel]()
            menu.append(contentsOf: result.icons ?? [MMHomeIconBannerModel]())
            menu.append(contentsOf: result.small_icons ?? [MMHomeIconBannerModel]())
            self?.menuItems = menu
            self?.headView.reloadMenuData(listData: menu)
            
        }, onError: { [weak self] error in
            self?.listPageView.mainTableView.endRefreshing()
            self?.hx_backgroundColor = UIColor.hexRGBAColor(MMHomeConfigService.shared.homeConfig.styles?.top_entrance?.bg_color ?? "rgba(255,255,255,1)")
            
            /// 首页菜单
            var menu = [MMHomeIconBannerModel]()
            menu.append(contentsOf: MMHomeConfigService.shared.homeConfig.icons ?? [MMHomeIconBannerModel]())
            menu.append(contentsOf: MMHomeConfigService.shared.homeConfig.small_icons ?? [MMHomeIconBannerModel]())
            self?.menuItems = menu
            self?.headView.reloadMenuData(listData: menu)
        })
        
       

        /// 跑马灯抡博
        _ = kHomeApiProvider.yn_request(.HomelistTipOff(pageId: 1)).subscribe(onNext: { [weak self] (json) in
            self?.listPageView.mainTableView.endRefreshing()
            guard let _result = MMPreferentMainListModel.deserialize(from: json) else { return }
            NSLog(json)
            self?.marqueeItems = _result.list ?? [MMPreferentMainModel]()
            self?.headView.reloadMarqueeBannerData(listData: self?.marqueeItems ?? [MMPreferentMainModel]())
        }, onError: { error in
            self.listPageView.mainTableView.endRefreshing()
        })
        
        /// 首页排行榜
        _ = kHomeApiProvider.yn_request(.HomeRankingList).subscribe(onNext: { (json) in
            let result = json.arrayValue.compactMap({MMHomeRankModel.deserialize(from: $0)})
            self.headView.reloadRankListsData(listData: result)
        }, onError: { (error) in
            self.listPageView.mainTableView.endRefreshing()
        })
        
        /// 首页秒杀
        _ = kHomeApiProvider.yn_request(.HomeDdqGoodsList).subscribe(onNext: { (json) in
         NSLog("首页秒杀==========\(json)")
        }, onError: { (error) in
            
        })
    
    }
    
    /// Menu Click
    func homeMainViewCollectionView(_ collectionView: MMHomeMenusView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.tabBarController?.selectedIndex = 1
        } else if indexPath.row == 1 {
            self.navigationController?.pushViewController(MMHomeLargeCouponController(), animated: true)
        }
    }
    
    private var menuItems = [MMHomeIconBannerModel]()
    private var marqueeItems = [MMPreferentMainModel]()
    
    private lazy var listPageView: JXPagingView = {
        let _v = JXPagingView(delegate: self, listContainerType: .scrollView)
        _v.listContainerView.isCategoryNestPagingEnabled = true
       _v.mainTableView.gestureDelegate = self
       _v.mainTableView.backgroundColor = UIColor.clear
        _v.listContainerView.backgroundColor = UIColor.clear
       _v.automaticallyDisplayListVerticalScrollIndicator = false
       _v.mainTableView.showsHorizontalScrollIndicator = false
       _v.mainTableView.showsVerticalScrollIndicator = false
        return _v
    }()
    
    private lazy var segmentedView: JXSegmentedView = {
        let _v = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: Int(kScreenWidth), height: headerInSectionHeight))
        _v.backgroundColor = UIColor.dynamicColor( UIColor.white, darkColor: UIColor.hexColor(0x181818))
        _v.delegate = self
        _v.isContentScrollViewClickTransitionAnimationEnabled = false
        _v.dataSource = dataSource
        return _v
     }()
    
    private lazy var dataSource: MMHomeSegmentedTitleDataSource = {
      let _data = MMHomeSegmentedTitleDataSource()
      _data.titleNormalColor = UIColor.hexColor(0x666666)
      _data.titleSelectedColor = UIColor.hexColor(0xf21724)
        _data.titleNormalFont = UIFont.df_getCustomFontType(with: .Medium, fontSize: 17) ?? UIFont.systemFont(ofSize: 17)
        _data.titleSelectedFont = UIFont.df_getCustomFontType(with: .Medium, fontSize: 17) ?? UIFont.systemFont(ofSize: 17)
        _data.subtitleNormalFont = UIFont.df_getCustomFontType(with: .Medium, fontSize: 12) ?? UIFont.systemFont(ofSize: 12)
        _data.subtitleSelectedFont = UIFont.df_getCustomFontType(with: .Medium, fontSize: 12) ?? UIFont.systemFont(ofSize: 12)
      _data.isTitleColorGradientEnabled = false
      _data.isItemSpacingAverageEnabled = false
      _data.titles = [ "精选","女装","母婴","美妆","居家日用","鞋品","美食","文娱车品","数码家电","男装","内衣","箱包","配饰","户外运动","家装家纺"]
        _data.subtitles = ["精选好物","潮流穿搭","宝妈精选","达人推荐","实惠百货","潮牌特价","吃货福利","超低折扣","全网钜惠","品质优选","亲肤舒适","潮流出街","搭配精品", "健康生活","品质家居",]
      _data.isTitleZoomEnabled = false
      _data.itemSpacing = 10
      _data.itemWidth =  JXSegmentedViewAutomaticDimension
      _data.itemWidthIncrement = 30
      return _data
   }()
    
    private var tableHeaderViewHeight: Int {
        get {
            let cellMenuHeight = (kScreenWidth - STtrans(24)) * (62.4/184.6) + STtrans(28)
            
            let cellMarqueHeight = STtrans(66)
            
            let cellViewHeight = (kScreenWidth - STtrans(30)) * (89/184.6) + STtrans(12)
            
            return Int(cellMenuHeight + cellMarqueHeight + cellViewHeight)
        }
    }
    
    private var headerInSectionHeight: Int = Int(STtrans(65))
    
    private lazy var headView: MMHomeMainView = {
        let _v = MMHomeMainView()
        _v.delegate = self
        return _v
    }()
    
    private var homeList = [
        ["cid" : "-1", "desc" : "精选好物","cname" : "精选"],
        ["cid" : "1", "desc" : "潮流穿搭", "cname" : "女装"],
        ["cid" : "2", "desc" : "宝妈精选", "cname" : "母婴"],
        ["cid" : "3", "desc" : "达人推荐", "cname" : "美妆"],
        ["cid" : "4", "desc" : "实惠百货", "cname" : "居家日用"],
        ["cid" : "5", "desc" : "潮牌特价", "cname" : "鞋品"],
        ["cid" : "6", "desc" : "吃货福利", "cname" : "美食"],
        ["cid" : "7", "desc" : "超低折扣", "cname" : "文娱车品"],
        ["cid" : "8", "desc" : "全网钜惠", "cname": "数码家电"],
        ["cid" : "9", "desc" : "品质优选", "cname" : "男装"],
        ["cid" : "10", "desc" : "亲肤舒适", "cname": "内衣",],
        ["cid" : "11", "desc" : "潮流出街", "cname" : "箱包"],
        ["cid" : "12", "desc" : "搭配精品", "cname" : "配饰"],
        ["cid" : "13", "desc" : "健康生活", "cname" : "户外运动"],
        ["cid" : "14", "desc" : "品质家居", "cname" : "家装家纺"]]
    
}


extension MMHomeMainController: JXPagingViewDelegate, JXPagingMainTableViewGestureDelegate, JXSegmentedViewDelegate {
    
    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return  tableHeaderViewHeight
    }
    
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return  headView
    }
    
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return  headerInSectionHeight
    }
    
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }
    
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return dataSource.dataSource.count
    }
    
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        if index == 0 {
            return MMHomePageController(pageCid: -1)
        }
        else
        {
            return MMHomePageController(pageCid:(index))
        }
    }
    
    func mainTableViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func pagingView(_ pagingView: JXPagingView, mainTableViewDidScroll scrollView: UIScrollView) {
        
    }
    
    func pagingView(_ pagingView: JXPagingView, mainTableViewWillBeginDragging scrollView: UIScrollView) {
        
    }
    
    func pagingView(_ pagingView: JXPagingView, mainTableViewDidEndDragging scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func pagingView(_ pagingView: JXPagingView, mainTableViewDidEndDecelerating scrollView: UIScrollView) {
        
    }
    
    func pagingView(_ pagingView: JXPagingView, mainTableViewDidEndScrollingAnimation scrollView: UIScrollView) {
        
    }
    
    /// JXPagingMainTableViewGestureDelegate
    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // 禁止segmentedView左右滑动的时候，上下和左右都可以滚动
        if otherGestureRecognizer == segmentedView.collectionView.panGestureRecognizer {
            return false
        }
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
    
    /// JXSegmentedViewDelegate
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        self.listPageView.listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        self.listPageView.listContainerView.didClickSelectedItem(at: index)
    }
}
