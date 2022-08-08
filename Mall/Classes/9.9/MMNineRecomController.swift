//
//  MMNineRecomController.swift
//  Mall
//
//  Created by iOS on 2022/4/21.
//

import UIKit
import JXSegmentedView


class MMNineRecomController: MMBaseViewController {

    convenience init(itemModel: MMNineCateItemModel) {
        self.init(nibName: nil, bundle: nil)
        self.currItemModel = itemModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clear
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
            self?.hadnleRecomListData(isFirstRequest: true)
        }
        
        self.collectionView.MMFoot = RefreshFooter{ [weak self] in
            guard self != nil else { return }
            self?.hadnleRecomListData()
        }
        
        self.collectionView.MMHead?.beginRefreshing()
    }
    
    
    private func hadnleRecomListData(isFirstRequest: Bool = false) {
        
        if isFirstRequest {
            _ = kNineApiProvider.yn_request(.NinePageGoodsTop).subscribe(onNext: { [weak self] (json) in
                self?.collectionView.endRefreshing()
                guard let _result = MMNineTopGoodListModel.deserialize(from:json) else { return }
                
                self?.robbingNum = _result.robbingNum
                self?.dataTopLists = _result.goodsList ?? [MMNineTopGoodModel]()
                
                self?.collectionView.reloadData()
                
            }, onError: { error in
                self.collectionView.endRefreshing()
                self.collectionView.reloadData()
            })
        }
        
        if ((self.currItemModel.id?.isNotBlank()) != nil)  {
            _ = kNineApiProvider.yn_request(.NinePageGoods(cid: self.currItemModel.id ?? "", pageNo: self.currentPage)).subscribe(onNext: { [weak self] (json) in
                self?.collectionView.endRefreshing()
                let jsonRes = json.dictionary
                guard let _result = MMNineGoodItemListModel.deserialize(from: jsonRes?["data"] ?? json) else { return }
                
                if self?.currentPage == 1 {
                    self?.dataLists.removeAll()
                }
                
                self?.dataLists.append(contentsOf: _result.lists ?? [MMNineGoodItemModel]())
                
                self?.collectionView.reloadData()
                
                if (self?.dataLists.count ?? 0) > (_result.totalCount ) {
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
        
    }
    
    
    private var currItemModel = MMNineCateItemModel()
    private var currentPage: Int = 1
    private var robbingNum: Int = 0
    
    private var dataTopLists = [MMNineTopGoodModel]()
    private var dataLists = [MMNineGoodItemModel]()
    
    private lazy var flowlayout: UICollectionViewFlowLayout = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        flowlayout.sectionInset = UIEdgeInsets(top: STtrans(12), left: STtrans(12), bottom: STtrans(12), right: STtrans(12))
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
        _v.register(MMNineRecomTopCollectionCell.self, forCellWithReuseIdentifier: "MMNineRecomTopCollectionCell")
        _v.register(MMNinePageCollectionGoodCell.self, forCellWithReuseIdentifier: "MMNinePageCollectionGoodCell")
        _v.register(MMNineRecomReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MMNineRecomReusableView")
        return _v
    }()
}

extension MMNineRecomController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return self.dataLists.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMNineRecomTopCollectionCell", for: indexPath) as! MMNineRecomTopCollectionCell
            
            cell.reloadTopCellListData(listModel: self.dataTopLists)
            
            cell.MMNineRecomTopCollectionCellBlock = { (val) in
                self.navigationController?.pushViewController(MMGoodsDetailsTbController(goodId: val.goodsid ?? ""), animated: true)
            }
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMNinePageCollectionGoodCell", for: indexPath) as! MMNinePageCollectionGoodCell
            
            if self.dataLists.count > indexPath.row {
                cell.cellItemData(itemModel: self.dataLists[indexPath.row])
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.dataLists.count > indexPath.row && indexPath.section != 0 {
            self.navigationController?.pushViewController(MMGoodsDetailsTbController(goodId: self.dataLists[indexPath.row].goodsid ?? ""), animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.width, height: collectionView.width*(187.0/414.0))
        default:
            return CGSize(width: (collectionView.width - STtrans(36))*0.5, height: (collectionView.width - STtrans(36))*0.75)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: collectionView.width, height: STtrans(23))
        default:
            return CGSize(width: collectionView.width, height: STtrans(38))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MMNineRecomReusableView", for: indexPath) as! MMNineRecomReusableView
            
            view.handleHeadVie(indexPath: indexPath, robbingNum: self.robbingNum)
            
            return view
        }
        else
        {
            return UICollectionReusableView()
        }
    }
    
}

extension MMNineRecomController: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return self.view
    }
    
}
