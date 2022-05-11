//
//  MMHomePageController.swift
//  Mall
//
//  Created by iOS on 2022/3/1.
//

import UIKit
import JXPagingView


class MMHomePageController: MMBaseViewController {
    
    private var listViewDidScrollCallback: ((UIScrollView) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        
    }
    
    override func bind() {
        
    }
    

    private lazy var collectionView: UICollectionView = {
        let _flowLayout = UICollectionViewFlowLayout()
        let _v = UICollectionView(frame: CGRect.zero, collectionViewLayout: _flowLayout)
        _v.delegate = self
        _v.dataSource = self
        _v.backgroundColor = UIColor.dynamicColor(UIColor.white, darkColor: UIColor.hexColor((0x1A1A1A)))
       _v.register(MMHomePageCollectionGoodCell.self, forCellWithReuseIdentifier: "MMHomePageCollectionGoodCell")
        return _v
    }()
}


extension MMHomePageController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMHomePageCollectionGoodCell", for: indexPath) as! MMHomePageCollectionGoodCell
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.zero
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
