//
//  MMCateGoryTBDetailController.swift
//  Mall
//
//  Created by iOS on 2022/4/2.
//

import UIKit

class MMCateGoryTBDetailController: UIViewController {

    convenience init(goodId: String) {
        self.init(nibName: nil, bundle: nil)
        self.currentGoodId = goodId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
        bind()
    }
    

    private func setUpUI() {
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func bind() {
        /// 商品数据
        _ = kCategoryApiProvider.yn_request(.getTaoBaoGoodsDetails(goodsId: self.currentGoodId)).subscribe(onNext: { [weak self] (json) in
            self?.collectionView.endRefreshing()
            
            let _model = MMCategoryPublicGoodModel.deserialize(from: json)
            self?.currentGoodModel = _model
            UIView.performWithoutAnimation {
                self?.collectionView.reloadData()
            }
        }, onError: { [weak self] error in
            self?.collectionView.endRefreshing()
        })
        
        /// 推荐
        _ = kCategoryApiProvider.yn_request(.getTaoBaolistSimilerGoods(goodsId: self.currentGoodId)).subscribe(onNext: { [weak self] (json) in
            self?.collectionView.endRefreshing()
            let result = json.arrayValue.compactMap({MMCategoryPublicGoodModel.deserialize(from: $0)})
            
            self?.recommListData = result
            UIView.performWithoutAnimation {
                self?.collectionView.reloadData()
            }
        }, onError: { [weak self] error in
            self?.collectionView.endRefreshing()
        })
        
    }

    private var currentGoodId: String = ""
    private var currentGoodModel: MMCategoryPublicGoodModel?
    
    /// 推荐商品数据
    private var recommListData = [MMCategoryPublicGoodModel]()
    
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
        _v.register(MMCategoryBannerCollectionCell.self, forCellWithReuseIdentifier: "MMCategoryBannerCollectionCell")
        _v.register(MMCateGoryRecomCollectionCell.self, forCellWithReuseIdentifier: "MMCateGoryRecomCollectionCell")
        return _v
    }()
    
}

extension MMCateGoryTBDetailController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.recommListData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMCategoryBannerCollectionCell", for: indexPath) as! MMCategoryBannerCollectionCell
            if self.currentGoodModel?.imgs?.count ?? 0 > 0 {
                bannerCell.reloadTbDetailBannerData(list: self.currentGoodModel?.imgs ?? "")
            }
            return bannerCell
        }
        else
        {
            let recomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMCateGoryRecomCollectionCell", for: indexPath) as! MMCateGoryRecomCollectionCell
            if indexPath.row < self.recommListData.count {
                recomCell.reloadRecomCellData(recomData: self.recommListData[indexPath.row])
            }
            return recomCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.width, height: collectionView.width)
        default:
            return CGSize(width: (collectionView.width - 18)*0.5, height: (collectionView.width - 18)*0.75)
        }
    }
    
    
}
