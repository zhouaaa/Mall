//
//  MMCateGoryRecomCollectionCell.swift
//  Mall
//
//  Created by iOS on 2022/4/2.
//

import UIKit

class MMCateGoryRecomCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.markUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func markUI() {
    
        self.contentView.addSubview(self.goodImageV)
        self.goodImageV.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(self.goodImageV.snp.width).multipliedBy(1.0)
        }
        
        self.contentView.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.goodImageV.snp.bottom)
            make.left.equalTo(self.goodImageV.snp.left).offset(4)
            make.right.equalTo(self.goodImageV.snp.right).offset(-4)
        }
    }
    
    
    func reloadRecomCellData(recomData: MMCategoryPublicGoodModel) {
        
        self.goodImageV.setImageWith(URL(string: "\(recomData.mainPic ?? "")"), placeholder: kGlobalDefultImage)
        
        self.titleLabel.text = "\(recomData.title ?? recomData.skuName ?? "")"
        
    }
    
    
    private lazy var goodImageV: UIImageView = {
        let _v = UIImageView()
        return _v
    }()

    private lazy var titleLabel: UILabel = {
        let _lab = UILabel()
        _lab.font = UIFont.systemFont(ofSize: 14)
        _lab.textColor = UIColor.hexColor(0x666666)
        _lab.textAlignment = .left
        _lab.lineBreakMode = .byTruncatingTail
        _lab.numberOfLines = 2
        return _lab
    }()
    
}
