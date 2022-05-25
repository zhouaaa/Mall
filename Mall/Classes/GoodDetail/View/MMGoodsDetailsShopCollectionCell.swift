//
//  MMGoodsDetailsShopCollectionCell.swift
//  Mall
//
//  Created by iOS on 2022/5/25.
//

import UIKit

class MMGoodsDetailsShopCollectionCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.markUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func markUI() {
        
        self.contentView.addSubview(self.shopImageV)
        self.shopImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(12)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.height.equalTo(STtrans(50))
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.shopImageV.snp.right).offset(10)
            make.top.equalTo(self.shopImageV.snp.top)
        }
        
        
        self.contentView.addSubview(self.desLabel)
        self.desLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.bottom.equalTo(self.shopImageV.snp.bottom)
        }
        
        
        self.contentView.addSubview(self.serviceLabel)
        self.serviceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.desLabel.snp.right).offset(8)
            make.centerY.equalTo(self.desLabel.snp.centerY)
        }
        
        self.contentView.addSubview(self.shipLabel)
        self.shipLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.serviceLabel.snp.centerY)
            make.left.equalTo(self.serviceLabel.snp.right).offset(8)
        }
        
    }
    
    
    func setShopCellData(cellItem: MMCategoryPublicGoodModel)  {
        
        self.titleLabel.text = "\(cellItem.shopName ?? "")"
        
        self.desLabel.text = "描述：\(cellItem.descScore ?? 0)"
        
        self.serviceLabel.text = "卖家：\(cellItem.serviceScore ?? 0)"
        
        self.shipLabel.text = "物流：\(cellItem.shipScore ?? 0)"
        
    }
    
    private lazy var shopImageV: UIImageView = {
        let _v = UIImageView()
        _v.image = UIImage(data: Data(base64Encoded: shopString)!)
        return _v
    }()
    
    private lazy var titleLabel: UILabel = {
        let _lab = UILabel()
       _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 14)
       _lab.textColor = UIColor.hexColor(0x000000)
       _lab.textAlignment = .left
        return _lab
    }()
    
    private lazy var desLabel: UILabel = {
        let _lab = UILabel()
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 12)
       _lab.textColor = UIColor.hexColor(0x888888)
       _lab.textAlignment = .left
        _lab.text = "描述："
        return _lab
    }()
    
    private lazy var serviceLabel: UILabel = {
        let _lab = UILabel()
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 12)
       _lab.textColor = UIColor.hexColor(0x888888)
       _lab.textAlignment = .left
        _lab.text = "卖家："
        return _lab
    }()
    
    private lazy var shipLabel: UILabel = {
        let _lab = UILabel()
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 12)
        _lab.textColor = UIColor.hexColor(0x888888)
        _lab.textAlignment = .left
        _lab.text = "物流："
        return _lab
    }()
    
    private let shopString: String = "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"
}
