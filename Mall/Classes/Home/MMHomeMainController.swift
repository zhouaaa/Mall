//
//  MMHomeMainController.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import UIKit
import JXPagingView
import JXSegmentedView

class MMHomeMainController: MMBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        
    }
    
    
    override func setupUI() {
        
        self.view.addSubview(self.listPageView)
        self.listPageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.segmentedView.contentScrollView = self.listPageView.listContainerView.scrollView
    }
    override func bind() {

        _ = kCategoryApiProvider.yn_request(.superCategory).subscribe(onNext: { (json) in
            let result = json.arrayValue.compactMap({MMCategoryListModel.deserialize(from: $0)})
            self.tabbarItems = result
            self.reloadHomeDataCateGory()
        }, onError: { (error) in

        })
        
        
        _ = kHomeApiProvider.yn_request(.HomeCmsV2Ads(siteId:"369616", temp_id: "2", page: 1)).subscribe(onNext: { (json) in
            let result = MMHomeMainModel.deserialize(from: json)
            
            self.homeMainModel = result ?? MMHomeMainModel()
            var menu = [MMHomeIconBannerModel]()
            menu.append(contentsOf: result?.icons ?? [MMHomeIconBannerModel]())
            menu.append(contentsOf: result?.small_icons ?? [MMHomeIconBannerModel]())
            self.headView.reloadMenuData(listData: menu)
        }, onError: { error in
            
        })
        
    }

    
    private func reloadHomeDataCateGory() {
        if self.tabbarItems.count <= 0 {
            return
        }
        
        var titleStringLists = [String]()
        self.tabbarItems.forEach { (valTab) in
            titleStringLists.append(valTab.cname ?? "")
        }
        self.dataSource.titles = titleStringLists
        self.segmentedView.reloadData()
        self.listPageView.reloadData()
    }
    
    
    private var tabbarItems = [MMCategoryListModel]()
    
    private var homeMainModel: MMHomeMainModel?
    
    private lazy var listPageView: JXPagingListRefreshView = {
        let _v = JXPagingListRefreshView(delegate: self, listContainerType: .scrollView)
        _v.listContainerView.isCategoryNestPagingEnabled = true
       _v.listContainerView.backgroundColor = UIColor.clear
       _v.mainTableView.gestureDelegate = self
       _v.mainTableView.backgroundColor = UIColor.clear
       _v.automaticallyDisplayListVerticalScrollIndicator = false
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
    
    private lazy var dataSource: JXSegmentedTitleDataSource = {
      let _data = JXSegmentedTitleDataSource()
      _data.titleNormalColor = UIColor.hexColor(0x666666)
      _data.titleSelectedColor = UIColor.hexColor(0xf21724)
        _data.titleNormalFont = UIFont.systemFont(ofSize: 14)
        _data.titleSelectedFont = UIFont.boldSystemFont(ofSize: 14)
      _data.isTitleColorGradientEnabled = false
      _data.isItemSpacingAverageEnabled = false
      _data.isTitleZoomEnabled = false
      _data.itemSpacing = 10
      _data.itemWidth =  JXSegmentedViewAutomaticDimension
      _data.itemWidthIncrement = 20
      return _data
   }()
    
    private var tableHeaderViewHeight: Int = Int(400.0)
    
    private var headerInSectionHeight: Int = Int(44.0)
    
    private lazy var headView: MMHomeMainView = {
        let _v = MMHomeMainView(frame: CGRect(x: 0, y: 0, width: Int(kScreenWidth), height: tableHeaderViewHeight))
        return _v
    }()
    
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
        return MMHomePageController()
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
