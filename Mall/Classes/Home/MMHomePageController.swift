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
        
        self.collectionView.MMFoot = RefreshFooter{ [weak self] in
            guard self != nil else { return }
            self?.handleHomePageData()
        }
        
        /// 获取数据
        self.currentPage = 1
        self.handleHomePageData()
    
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
        
        
        if self.currentCid == -1 {
            _ = kHomeApiProvider.yn_request(.HomeCmsV2Ads(siteId:"369616", temp_id: "2", page: 1)).subscribe(onNext: { (json) in
                self.collectionView.endRefreshing()
                let result = MMHomeMainModel.deserialize(from: json)
                
                self.bannerLists = result?.h_banners ?? [MMHomeIconBannerModel]()
                self.collectionView.reloadData()
            }, onError: { error in
                self.collectionView.endRefreshing()
                self.collectionView.reloadData()
            })
        }
        
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        let _v = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
        _v.showsVerticalScrollIndicator = false
        _v.showsHorizontalScrollIndicator = false
        _v.delegate = self
        _v.dataSource = self
        _v.backgroundColor = UIColor.clear
        _v.register(MMHomePageCollectionGoodCell.self, forCellWithReuseIdentifier: MMHomePageCollectionGoodCell.reuseId)
        _v.register(MMHomePageBannerCollectionCell.self, forCellWithReuseIdentifier: MMHomePageBannerCollectionCell.reuseId)
        return _v
    }()
    
    
    private var dataLists = [MMHomeGoodItemModel]()
    private var bannerLists = [MMHomeIconBannerModel]()
    private var currentPage: Int = 1
    private var currentCid: Int = -1
    private var listViewDidScrollCallback: ((UIScrollView) -> ())?
}


extension MMHomePageController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bannerLists.count > 0 ? (self.dataLists.count + 1) : self.dataLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.bannerLists.count > 0 && indexPath.row == 0 {
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: MMHomePageBannerCollectionCell.reuseId, for: indexPath) as! MMHomePageBannerCollectionCell
            
            bannerCell.setRecomBannerItem(list: self.bannerLists)
            
            return bannerCell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MMHomePageCollectionGoodCell.reuseId, for: indexPath) as! MMHomePageCollectionGoodCell
            
            if self.bannerLists.count > 0 {
                if self.dataLists.count > (indexPath.row - 1) {
                    cell.cellItemData(itemModel: self.dataLists[indexPath.row - 1])
                }
            } else {
                if self.dataLists.count > indexPath.row {
                    cell.cellItemData(itemModel: self.dataLists[indexPath.row])
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.bannerLists.count > 0 {
            if self.dataLists.count > (indexPath.row - 1) {
                self.navigationController?.pushViewController(MMGoodsDetailsTbController(goodId: self.dataLists[indexPath.row].goodsId ?? ""), animated: true)
            }
        } else {
            if self.dataLists.count > indexPath.row {
                self.navigationController?.pushViewController(MMGoodsDetailsTbController(goodId: self.dataLists[indexPath.row].goodsId ?? ""), animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.width - STtrans(36))*0.5
        return CGSize(width: cellWidth, height: cellWidth*(295.28/179.41))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return STtrans(6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return STtrans(12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: STtrans(6), left: STtrans(12), bottom: 0, right: STtrans(12))
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
