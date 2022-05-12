//
//  MMHomePageController.swift
//  Mall
//
//  Created by iOS on 2022/3/1.
//

import UIKit
import JXPagingView


class MMHomePageController: MMBaseViewController {
    

    convenience init(pageCid: Int) {
        self.init(nibName: nil, bundle: nil)
        self.currentCid = pageCid
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func bind() {
        
        self.collectionView.MMHead = RefreshHeader{ [weak self] in
            guard self != nil else { return }
            self?.currentPage = 1
            self?.handleHomePageData()
        }
        
        self.collectionView.MMFoot = RefreshFooter{ [weak self] in
            guard self != nil else { return }
            self?.handleHomePageData()
        }
        
        self.collectionView.MMHead?.beginRefreshing()
        
    }
    
    private func handleHomePageData() {
        
        _ = kHomeApiProvider.yn_request(.HomeGoodLists(cids: self.currentCid, pageId: self.currentPage)).subscribe(onNext: { [weak self] (json) in
            self?.collectionView.endRefreshing()
            guard let _result = MMHomeGoodListModel.deserialize(from:json) else { return }
            
            if self?.currentPage == 1 {
                self?.dataLists.removeAll()
            }
            
            self?.dataLists.append(contentsOf: _result.list ?? [MMHomeGoodItemModel]())
            
            self?.collectionView.reloadData()
            
            if (self?.dataLists.count ?? 0) > (_result.totalNum) {
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
        _v.register(MMHomePageCollectionGoodCell.self, forCellWithReuseIdentifier: "MMHomePageCollectionGoodCell")
        return _v
    }()
    
    
    private var dataLists = [MMHomeGoodItemModel]()
    
    private var currentPage: Int = 1
    
    private var currentCid: Int = -1
    
    private var listViewDidScrollCallback: ((UIScrollView) -> ())?
}


extension MMHomePageController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMHomePageCollectionGoodCell", for: indexPath) as! MMHomePageCollectionGoodCell
        
        if self.dataLists.count > indexPath.row {
            cell.cellItemData(itemModel: self.dataLists[indexPath.row])
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.width - 36)*0.5, height: (collectionView.width - 36)*0.75)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listViewDidScrollCallback?(scrollView)
    }

    
}


extension MMHomePageController: JXPagingViewListViewDelegate {
    
    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }
    
    func listScrollView() -> UIScrollView {
        return self.collectionView
    }
    
    func listView() -> UIView {
        return view
    }
    
}
