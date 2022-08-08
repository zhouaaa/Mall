//
//  MMGoodsDetailsDesCollectionCell.swift
//  Mall
//
//  Created by iOS on 2022/5/25.
//

import UIKit

class MMGoodsDetailsDesCollectionCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.markUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func markUI() {
    
        self.contentView.addSubview(self.iconImageV)
        self.iconImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(12)
            make.top.equalTo(self.contentView.snp.top).offset(8)
            make.width.height.equalTo(STtrans(28))
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImageV.snp.right).offset(STtrans(6))
            make.centerY.equalTo(self.iconImageV.snp.centerY)
        }
        
        self.contentView.addSubview(self.msgLabel)
        self.msgLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImageV.snp.left)
            make.right.equalTo(self.contentView.snp.right).offset(-12)
            make.top.equalTo(self.iconImageV.snp.bottom).offset(8)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
        }
        
    }
    
    
    func setdesCellData(cellItem: String) {
        self.msgLabel.text = cellItem
    }
    
    private lazy var iconImageV: UIImageView = {
        let _v = UIImageView()
        _v.setImageWithURL("https://cmsstaticv2.ffquan.cn/img/head.fb5d716f.png")
        return _v
    }()
    
    lazy var titleLabel: UILabel = {
        let _lab = UILabel()
       _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 14)
       _lab.textColor = UIColor.hexColor(0xFE3738)
       _lab.textAlignment = .left
       _lab.text = "达人推荐"
        return _lab
    }()
    
    private lazy var msgLabel: MMPaddingLabel = {
        let _lab = MMPaddingLabel()
        _lab.backgroundColor = UIColor.hexColor(0xf4f4f4)
        _lab.font = UIFont.df_getCustomFontType(with: .Regular, fontSize: 12)
        _lab.textColor = UIColor.hexColor(0x555555)
        _lab.textInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        _lab.textAlignment = .left
        _lab.numberOfLines = 0
        _lab.layer(radius: 2, borderWidth: 0.0, borderColor: UIColor.hexColor(0xf4f4f4))
        return _lab
    }()
    
    private let desString: String = "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"
}
