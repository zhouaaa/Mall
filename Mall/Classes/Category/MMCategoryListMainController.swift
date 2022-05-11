//
//  MMCategoryListMainController.swift
//  Mall
//
//  Created by iOS on 2022/3/31.
//

import UIKit
import JXPagingView
import JXSegmentedView

class MMCategoryListMainController: MMBaseViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hx_enablePopGesture = (self.segmentView.selectedIndex == 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.hx_enablePopGesture = true
    }
    
    convenience init(listKeyWordModel: MMCategorySubcategoriesModel) {
        self.init(nibName: nil, bundle: nil)
        self.listkeyModel = listKeyWordModel
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func setupUI() {
        
        self.navigationItem.title = self.listkeyModel.subcname
        
        self.view.addSubview(self.segmentView)
        self.segmentView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(44)
        }

        self.view.addSubview(self.listContainerView)
        self.listContainerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(segmentView.snp.bottom)
        }
        
        self.segmentView.contentScrollView = self.listContainerView.scrollView
        
    }
    
    override func bind() {

    }

    private var listkeyModel = MMCategorySubcategoriesModel()
    

    private lazy var segmentView: JXSegmentedView = {
         let _v = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 40, height: 44))
         _v.contentEdgeInsetLeft = 20
         _v.contentEdgeInsetRight = 20
         _v.dataSource = segmentedSource
         _v.isContentScrollViewClickTransitionAnimationEnabled = true
         _v.delegate = self
        
        let _indicator = JXSegmentedIndicatorLineView()
        _indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        _indicator.indicatorWidthIncrement = -10
        _indicator.indicatorHeight = 4
        _indicator.indicatorCornerRadius = 2
        _indicator.verticalOffset = 3
        _indicator.lineStyle = .normal
        _indicator.indicatorColor = UIColor.dynamicColor(UIColor.hexColor(0xf21724), darkColor: UIColor.white)
        _indicator.indicatorPosition = .bottom
        _v.indicators = [_indicator]
         return _v
     }()
     
     private lazy var segmentedSource: JXSegmentedTitleDataSource = {
         let _segSource = JXSegmentedTitleDataSource()
         _segSource.titles = ["淘宝", "京东", "抖音电商"]
         _segSource.titleNormalColor = UIColor.hexColor(0x999999)
         _segSource.titleSelectedColor = UIColor.hexColor(0x333333)
         _segSource.titleNormalFont = UIFont.systemFont(ofSize: 14)
         _segSource.titleSelectedFont = UIFont.systemFont(ofSize: 15)
         _segSource.isItemSpacingAverageEnabled = false
         _segSource.isTitleColorGradientEnabled = true
         _segSource.itemSpacing = 30
         _segSource.itemWidth = JXSegmentedViewAutomaticDimension
         return _segSource
     }()
    
    private lazy var listContainerView: JXSegmentedListContainerView = {
        let _listV =  JXSegmentedListContainerView(dataSource: self, type: .scrollView)
        _listV.backgroundColor = .clear
        _listV.scrollView.backgroundColor = .clear
        return _listV
    }()
    
}


extension MMCategoryListMainController: JXSegmentedListContainerViewDataSource, JXSegmentedViewDelegate {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return self.segmentedSource.titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return MMCategoryListController(KeyWordModel: self.listkeyModel, sourceType: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        self.listContainerView.didClickSelectedItem(at: index)
        self.navigationController?.hx_enablePopGesture = (segmentedView.selectedIndex == 0)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, canClickItemAt index: Int) -> Bool {
        return true
    }
}
