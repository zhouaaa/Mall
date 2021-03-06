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
            
            /// ้ฆ้กต่ๅ
            var menu = [MMHomeIconBannerModel]()
            menu.append(contentsOf: result.icons ?? [MMHomeIconBannerModel]())
            menu.append(contentsOf: result.small_icons ?? [MMHomeIconBannerModel]())
            self?.menuItems = menu
            self?.headView.reloadMenuData(listData: menu)
            
        }, onError: { [weak self] error in
            self?.listPageView.mainTableView.endRefreshing()
            self?.hx_backgroundColor = UIColor.hexRGBAColor(MMHomeConfigService.shared.homeConfig.styles?.top_entrance?.bg_color ?? "rgba(255,255,255,1)")
            
            /// ้ฆ้กต่ๅ
            var menu = [MMHomeIconBannerModel]()
            menu.append(contentsOf: MMHomeConfigService.shared.homeConfig.icons ?? [MMHomeIconBannerModel]())
            menu.append(contentsOf: MMHomeConfigService.shared.homeConfig.small_icons ?? [MMHomeIconBannerModel]())
            self?.menuItems = menu
            self?.headView.reloadMenuData(listData: menu)
        })
        
       

        /// ่ท้ฉฌ็ฏๆกๅ
        _ = kHomeApiProvider.yn_request(.HomelistTipOff(pageId: 1)).subscribe(onNext: { [weak self] (json) in
            self?.listPageView.mainTableView.endRefreshing()
            guard let _result = MMPreferentMainListModel.deserialize(from: json) else { return }
            NSLog(json)
            self?.marqueeItems = _result.list ?? [MMPreferentMainModel]()
            self?.headView.reloadMarqueeBannerData(listData: self?.marqueeItems ?? [MMPreferentMainModel]())
        }, onError: { error in
            self.listPageView.mainTableView.endRefreshing()
        })
        
        /// ้ฆ้กตๆ่กๆฆ
        _ = kHomeApiProvider.yn_request(.HomeRankingList).subscribe(onNext: { (json) in
            let result = json.arrayValue.compactMap({MMHomeRankModel.deserialize(from: $0)})
            self.headView.reloadRankListsData(listData: result)
        }, onError: { (error) in
            self.listPageView.mainTableView.endRefreshing()
        })
        
        /// ้ฆ้กต็งๆ
        _ = kHomeApiProvider.yn_request(.HomeDdqGoodsList).subscribe(onNext: { (json) in
         NSLog("้ฆ้กต็งๆ==========\(json)")
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
      _data.titles = [ "็ฒพ้","ๅฅณ่ฃ","ๆฏๅฉด","็พๅฆ","ๅฑๅฎถๆฅ็จ","้ๅ","็พ้ฃ","ๆๅจฑ่ฝฆๅ","ๆฐ็?ๅฎถ็ต","็ท่ฃ","ๅ่กฃ","็ฎฑๅ","้้ฅฐ","ๆทๅค่ฟๅจ","ๅฎถ่ฃๅฎถ็บบ"]
        _data.subtitles = ["็ฒพ้ๅฅฝ็ฉ","ๆฝฎๆต็ฉฟๆญ","ๅฎๅฆ็ฒพ้","่พพไบบๆจ่","ๅฎๆ?็พ่ดง","ๆฝฎ็็นไปท","ๅ่ดง็ฆๅฉ","่ถไฝๆๆฃ","ๅจ็ฝ้ๆ?","ๅ่ดจไผ้","ไบฒ่ค่้","ๆฝฎๆตๅบ่ก","ๆญ้็ฒพๅ", "ๅฅๅบท็ๆดป","ๅ่ดจๅฎถๅฑ",]
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
        ["cid" : "-1", "desc" : "็ฒพ้ๅฅฝ็ฉ","cname" : "็ฒพ้"],
        ["cid" : "1", "desc" : "ๆฝฎๆต็ฉฟๆญ", "cname" : "ๅฅณ่ฃ"],
        ["cid" : "2", "desc" : "ๅฎๅฆ็ฒพ้", "cname" : "ๆฏๅฉด"],
        ["cid" : "3", "desc" : "่พพไบบๆจ่", "cname" : "็พๅฆ"],
        ["cid" : "4", "desc" : "ๅฎๆ?็พ่ดง", "cname" : "ๅฑๅฎถๆฅ็จ"],
        ["cid" : "5", "desc" : "ๆฝฎ็็นไปท", "cname" : "้ๅ"],
        ["cid" : "6", "desc" : "ๅ่ดง็ฆๅฉ", "cname" : "็พ้ฃ"],
        ["cid" : "7", "desc" : "่ถไฝๆๆฃ", "cname" : "ๆๅจฑ่ฝฆๅ"],
        ["cid" : "8", "desc" : "ๅจ็ฝ้ๆ?", "cname": "ๆฐ็?ๅฎถ็ต"],
        ["cid" : "9", "desc" : "ๅ่ดจไผ้", "cname" : "็ท่ฃ"],
        ["cid" : "10", "desc" : "ไบฒ่ค่้", "cname": "ๅ่กฃ",],
        ["cid" : "11", "desc" : "ๆฝฎๆตๅบ่ก", "cname" : "็ฎฑๅ"],
        ["cid" : "12", "desc" : "ๆญ้็ฒพๅ", "cname" : "้้ฅฐ"],
        ["cid" : "13", "desc" : "ๅฅๅบท็ๆดป", "cname" : "ๆทๅค่ฟๅจ"],
        ["cid" : "14", "desc" : "ๅ่ดจๅฎถๅฑ", "cname" : "ๅฎถ่ฃๅฎถ็บบ"]]
    
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
        // ็ฆๆญขsegmentedViewๅทฆๅณๆปๅจ็ๆถๅ๏ผไธไธๅๅทฆๅณ้ฝๅฏไปฅๆปๅจ
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
