//
//  MMCategoryMainController.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import UIKit

class MMCategoryMainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
        self.bind()
    }

    private func setupUI() {
    
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(view.snp.width).multipliedBy(0.32)
        }
    
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.tableView)
            make.right.equalToSuperview()
            make.left.equalTo(self.tableView.snp.right)
        }
    }
    
    
   private func bind() {
       
       _ = kCategoryApiProvider.yn_request(.superCategory).subscribe(onNext: { (json) in
           let result = json.arrayValue.compactMap({MMCategoryListModel.deserialize(from: $0)})
           self.lists = result
           self.reloadGoodListView()
       }, onError: { (error) in

       })
   }
    
    private func reloadGoodListView() {
        self.tableView.reloadData()
        self.collectionView.reloadData()
        self.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
    }
    
   private var lists = [MMCategoryListModel]()
   //右侧collectionView当前是否正在向下滚动（即true表示手指向上滑动，查看下面内容）
   private var collectionViewIsScrollDown = true
   //右侧collectionView垂直偏移量
   private var collectionViewLastOffsetY : CGFloat = 0.0
    
   private lazy var tableView: UITableView = {
        let _tab = UITableView(frame: CGRect.zero, style: .plain)
        _tab.delegate = self
        _tab.dataSource = self
       _tab.register(MMCategorieTableLeftCell.self, forCellReuseIdentifier: "MMCategorieTableLeftCell")
       _tab.backgroundColor = UIColor.white
       _tab.showsHorizontalScrollIndicator = false
       _tab.showsVerticalScrollIndicator = false
        return _tab
    }()
    
    private lazy var flowlayout: UICollectionViewFlowLayout = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumLineSpacing = 4
        flowlayout.minimumInteritemSpacing = 6
        flowlayout.sectionHeadersPinToVisibleBounds = true
        return flowlayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let _v = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
        _v.delegate = self
        _v.dataSource = self
        _v.backgroundColor = UIColor.white
        _v.register(MMCategorieCollectionCell.self, forCellWithReuseIdentifier: "MMCategorieCollectionCell")
        _v.register(MMCategorieReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MMCategorieReusableView")
        return _v
    }()
    
}


extension MMCategoryMainController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MMCategorieTableLeftCell", for: indexPath)  as! MMCategorieTableLeftCell
        cell.reloadLeftCellData(cellData: lists[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// collection View 滚动
        self.collectionViewScrollToTop(section: indexPath.row, animated: true)
        /// tableView 滚动
        tableView.scrollToRow(at: IndexPath(row: indexPath.row, section: 0), at: .top, animated: true)
    }
    
    //将右侧colletionView的指定分区自动滚动到最顶端
    func collectionViewScrollToTop(section: Int, animated: Bool) {
        let headerRect = collectionViewHeaderFrame(section: section)
        
        let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y
                - collectionView.contentInset.top)
            collectionView.setContentOffset(topOfHeader, animated: animated)
    }
         
        
    //后获colletionView的指定分区头的高度
    func collectionViewHeaderFrame(section: Int) -> CGRect {
           
        let indexPath = IndexPath(item: 0, section: section)
        
        let attributes = collectionView.collectionViewLayout
                .layoutAttributesForSupplementaryView(ofKind:
                    UICollectionView.elementKindSectionHeader, at: indexPath)
        guard let frameForFirstCell = attributes?.frame else { return .zero}
        
        return frameForFirstCell;
    }

}


extension MMCategoryMainController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.lists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section < lists.count {
            return lists[section].subcategories?.count ?? 0
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMCategorieCollectionCell", for: indexPath) as! MMCategorieCollectionCell
        
        if lists.count > indexPath.section {
           let _model = lists[indexPath.section].subcategories?[indexPath.row] ?? MMCategorySubcategoriesModel()
            cell.setListData(_model)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if lists.count > indexPath.section {
           let _model = lists[indexPath.section].subcategories?[indexPath.row] ?? MMCategorySubcategoriesModel()
            self.navigationController?.pushViewController(MMCategoryListMainController(listKeyWordModel: _model), animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.width - 24)/3, height: (collectionView.width - 24)/3 + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.width, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MMCategorieReusableView", for: indexPath) as! MMCategorieReusableView
        view.titleLabel.text = lists[indexPath.section].cname
        return view
    }
    
    //分区头即将要显示时调用
    func collectionView(_ collectionView: UICollectionView,
                           willDisplaySupplementaryView view: UICollectionReusableView,
                           forElementKind elementKind: String, at indexPath: IndexPath) {
           //如果是由用户手动滑动屏幕造成的向上滚动，那么左侧表格自动选中该分区对应的分类
           if !collectionViewIsScrollDown
               && (collectionView.isDragging || collectionView.isDecelerating) {
               tableView.selectRow(at: IndexPath(row: indexPath.section, section: 0),
                                       animated: true, scrollPosition: .top)
           }
       }
        
       
    //分区头即将要消失时调用
    func collectionView(_ collectionView: UICollectionView,
                           didEndDisplayingSupplementaryView view: UICollectionReusableView,
                           forElementOfKind elementKind: String, at indexPath: IndexPath) {
           
        //如果是由用户手动滑动屏幕造成的向下滚动，那么左侧表格自动选中该分区对应的下一个分区的分类
        if collectionViewIsScrollDown
               && (collectionView.isDragging || collectionView.isDecelerating) {
               
            tableView.selectRow(at: IndexPath(row: indexPath.section + 1, section: 0),
                                   animated: true, scrollPosition: .top)
        
        }
    }
        
       
    //视图滚动时触发（主要用于记录当前collectionView是向上还是向下滚动）
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView == scrollView {
            collectionViewIsScrollDown = collectionViewLastOffsetY
                   < scrollView.contentOffset.y
           collectionViewLastOffsetY = scrollView.contentOffset.y
        }
    }
}
