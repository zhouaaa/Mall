//
//  MMGoodsDetailsPicCollectionCell.swift
//  Mall
//
//  Created by iOS on 2022/5/25.
//

import UIKit

class MMGoodsDetailsPicCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.white
//        self.layer(radius: 6, borderWidth: 0.0, borderColor: UIColor.white)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        self.contentView.addSubview(self.picImageV)
        self.picImageV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    
    func setDetailPic(cellImtem: MMCategoryGoodDetailPicsModel) {

        self.picImageV.setImageWith(URL(string: cellImtem.img?.contains(find: "https") ?? false ? cellImtem.img ?? "" : "http:\(cellImtem.img ?? "")"), placeholder: kGlobalDefultImage)
        
    }
    
    private lazy var picImageV: UIImageView = {
        let _v = UIImageView()
        _v.image = kGlobalDefultImage
        return _v
    }()
    
    
    
}
