//
//  MMCategorieCollectionCell.swift
//  Mall
//
//  Created by iOS on 2022/3/31.
//

import UIKit

class MMCategorieCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.markUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func markUI() {
        
        self.contentView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(4)
            make.right.equalTo(contentView.snp.right).offset(-4)
            make.bottom.equalTo(contentView.snp.bottom).offset(-2)
            make.height.equalTo(20)
        }
        
        
        self.contentView.addSubview(self.goodImageV)
        self.goodImageV.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(6)
            make.bottom.equalTo(nameLabel.snp.top).offset(-6)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(goodImageV.snp.height).multipliedBy(1.0)
        }
        
    }
    
    func setListData(_ model: MMCategorySubcategoriesModel) {
        nameLabel.text = model.subcname
        goodImageV.setImageWith(URL(string: model.scpic ?? ""))
    }
    
    
    private lazy var goodImageV: UIImageView = {
        let _v = UIImageView()
        _v.contentMode = .scaleAspectFit
        return _v
    }()
    
    private lazy var nameLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0x333333)
        _lab.textAlignment = .center
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 12)
        return _lab
    }()
}




class MMCategorieReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0xf21724)
        _lab.textAlignment = .center
        _lab.font = UIFont.df_getCustomFontType(with: .Regular, fontSize: 14)
        return _lab
    }()
}
