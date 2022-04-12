//
//  MMCategoryListController.swift
//  Mall
//
//  Created by iOS on 2022/3/31.
//

import UIKit
import JXSegmentedView


class MMCategoryListController: UIViewController {

    convenience init(KeyWordModel: MMCategorySubcategoriesModel, sourceType: Int) {
        self.init(nibName: nil, bundle: nil)
        
        self.currentPageType = sourceType
        self.cateGoryModel = KeyWordModel
        
        self.setupView()
        
        self.bind()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        
    }
    
    private func bind() {
        
        self.collectionView.MMHead = RefreshHeader{ [weak self] in
            guard self != nil else { return }
            self?.loadMoreGoodListData(isFirstRequest: true)
        }
        
        self.collectionView.MMFoot = RefreshFooter{ [weak self] in
            guard self != nil else { return }
            self?.loadMoreGoodListData(isFirstRequest: false)
        }
        
        self.collectionView.MMHead?.beginRefreshing()
        
    }
    

    
    private func loadMoreGoodListData(isFirstRequest: Bool = false) {
        
        if isFirstRequest {
            self.goodLists.removeAll()
            self.currentPage = 1
        }
        
        switch self.currentPageType {
        case 0: do {
            _ = kCategoryApiProvider.yn_request(.listSuperTaoBaoGoods(keyWords: self.cateGoryModel.subcname ?? "",  currentPage: self.currentPage)).subscribe(onNext: { [weak self] (json) in
                self?.collectionView.endRefreshing()
                guard let _result = MMCategoryGoodListModel.deserialize(from: json) else { return }
                
                self?.goodLists.append(contentsOf: _result.list ?? [MMCategoryPublicGoodModel]())
                
                self?.collectionView.reloadData()
                
                if (self?.goodLists.count ?? 0) > (_result.totalNum ?? 0) {
                    self?.collectionView.MMFoot?.endRefreshingWithNoMoreData()
                } else { self?.currentPage = +1 }
            }, onError: { [weak self] error in
                self?.collectionView.endRefreshing()
            })
        }
        break
        case 1: do {
            _ = kCategoryApiProvider.yn_request(.listSuperJingDongGoods(keyWords: self.cateGoryModel.subcname ?? "", currentPage: self.currentPage, pageSize: 10)).subscribe(onNext: { [weak self] (json) in
                self?.collectionView.endRefreshing()
                
                guard let _result = MMCategoryGoodListModel.deserialize(from: json) else { return }
                
                self?.goodLists.append(contentsOf: _result.list ?? [MMCategoryPublicGoodModel]())
                
                self?.collectionView.reloadData()
                
                if (self?.goodLists.count ?? 0) > (_result.totalNum ?? 0) {
                    self?.collectionView.MMFoot?.endRefreshingWithNoMoreData()
                } else { self?.currentPage = +1 }
            }, onError: { [weak self] error in
                self?.collectionView.endRefreshing()
            })
        }
        break
        case 2: do {
            _ = kCategoryApiProvider.yn_request(.listSupertTktokGoods(keyWords: self.cateGoryModel.subcname ?? "", searchType: 0, sortType: 0, currentPage: self.currentPage)).subscribe(onNext: { [weak self] (json) in
                self?.collectionView.endRefreshing()
                
                guard let _result = MMCategoryGoodListModel.deserialize(from: json) else { return }
                
                self?.goodLists.append(contentsOf: _result.list ?? [MMCategoryPublicGoodModel]())
                
                self?.collectionView.reloadData()
                
                if (self?.goodLists.count ?? 0) >= (_result.total ?? 0) {
                    self?.collectionView.MMFoot?.endRefreshingWithNoMoreData()
                } else { self?.currentPage = +1 }
            }, onError: { [weak self] error in
                self?.collectionView.endRefreshing()
            })
        }
        break
        default:
          break
        }
    }
    
     
    private var currentPage: Int = 1
    private var currentPageType: Int = 0
    private var cateGoryModel = MMCategorySubcategoriesModel()
    
    ///数据
    private var goodLists: [MMCategoryPublicGoodModel] = []
    
    private lazy var flowlayout: UICollectionViewFlowLayout = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.minimumLineSpacing = 6
        flowlayout.minimumInteritemSpacing = 6
        return flowlayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let _v = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
        _v.delegate = self
        _v.dataSource = self
        _v.backgroundColor = UIColor.white
        _v.register(MMCategoryListCollectionCell.self, forCellWithReuseIdentifier: "MMCategoryListCollectionCell")
        return _v
    }()
    
    
}

extension MMCategoryListController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.goodLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMCategoryListCollectionCell", for: indexPath) as! MMCategoryListCollectionCell
        
        if self.goodLists.count > indexPath.row {
            cell.reloadGoodCellData(cellData: self.goodLists[indexPath.row], cellType: self.currentPageType)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.currentPageType == 0 {
            self.navigationController?.pushViewController(MMCateGoryTBDetailController(goodId: self.goodLists[indexPath.row].goodsId ?? ""), animated: true)
        }
    }

    
}

extension MMCategoryListController: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return self.view
    }
    
}
