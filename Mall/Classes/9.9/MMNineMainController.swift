//
//  MMNineMainController.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import UIKit
import JXSegmentedView

class MMNineMainController: MMBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.hx_barStyle = .black
        self.hx_backgroundColor = UIColor.hexColor(0xff7300)
        
    }
    
    override func setupUI() {

        self.navigationItem.titleView = self.segmentedView
     
        self.view.addSubview(self.bgImageV)
        self.bgImageV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        self.view.addSubview(self.listContainerView)
        self.listContainerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func bind() {
        
        _ = kNineApiProvider.yn_request(.NinePageCate).subscribe(onNext: { (json) in
            let result = json.arrayValue.compactMap({MMNineCateItemModel.deserialize(from: $0)})
            self.nineCateLists = result
            self.reloadNineCateNavData()
        }, onError: { error in
            
        })
    }
    
    private func reloadNineCateNavData() {
        if self.nineCateLists.count <= 0 {
            return
        }
        
        var titleStringLists = [String]()
        self.nineCateLists.forEach { (valTab) in
            titleStringLists.append(valTab.title ?? "")
        }
        self.dataSource.titles = titleStringLists
        self.segmentedView.reloadData()
        self.listContainerView.reloadData()
    }
    
    
    private var nineCateLists = [MMNineCateItemModel]()
    
    private lazy var bgImageV: UIImageView = {
        let _v = UIImageView()
        _v.image = UIImage(named: "nine_main_bg")
        return _v
    }()
    
    private lazy var segmentedView: JXSegmentedView = {
        let _v = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: Int(kScreenWidth), height: 44))
        _v.backgroundColor = .clear
        _v.delegate = self
        _v.isContentScrollViewClickTransitionAnimationEnabled = false
        _v.dataSource = dataSource
        let lineView = JXSegmentedIndicatorLineView()
        //lineView.indicatorWidthIncrement = 10
        lineView.indicatorHeight = 4
        lineView.indicatorColor = UIColor.white
        lineView.indicatorCornerRadius = 2
        _v.indicators = [lineView]
        _v.contentScrollView = self.listContainerView.scrollView
        return _v
     }()
    
    private lazy var dataSource: JXSegmentedTitleDataSource = {
      let _data = JXSegmentedTitleDataSource()
        _data.titleNormalColor = UIColor.white.withAlphaComponent(0.8)
        _data.titleSelectedColor = UIColor.white
        _data.titleNormalFont = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 16) ?? UIFont.systemFont(ofSize: 16)
      _data.titleSelectedFont = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 17) ?? UIFont.systemFont(ofSize: 17)
      _data.isTitleColorGradientEnabled = false
      _data.isItemSpacingAverageEnabled = false
      _data.isTitleZoomEnabled = false
      _data.itemSpacing = 10
      _data.itemWidth =  JXSegmentedViewAutomaticDimension
      _data.itemWidthIncrement = 20
      return _data
   }()
    
    private lazy var listContainerView: JXSegmentedListContainerView = {
        let _listV =  JXSegmentedListContainerView(dataSource: self, type: .scrollView)
        _listV.backgroundColor = .clear
        _listV.scrollView.backgroundColor = .clear
        return _listV
    }()
}


extension MMNineMainController: JXSegmentedListContainerViewDataSource, JXSegmentedViewDelegate {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return self.dataSource.titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        switch index {
        case 0:
            return MMNineRecomController(itemModel: self.nineCateLists[index])
        default:
            return MMNinePageController(itemModel: self.nineCateLists[index])
        }
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        self.listContainerView.didClickSelectedItem(at: index)
    }
    

    
}
