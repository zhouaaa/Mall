//
//  MMCategoryListCollectionCell.swift
//  Mall
//
//  Created by iOS on 2022/3/31.
//

import UIKit


class MMCategoryListCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        markUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func markUI() {
        
        self.backgroundColor = UIColor.hexColor(0xffffff)
        
        self.contentView.addSubview(self.goodImageV)
        self.goodImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(12)
            make.top.equalTo(self.snp.top).offset(8)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
            make.width.equalTo(goodImageV.snp.height).multipliedBy(1.0)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.goodImageV.snp.right).offset(8)
            make.top.equalTo(goodImageV.snp.top)
            make.right.equalTo(self.snp.right).offset(-12)
        }
        
        self.contentView.addSubview(self.shopNameLabel)
        self.shopNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.goodImageV.snp.bottom)
            make.left.equalTo(self.titleLabel.snp.left)
        }
        
        self.contentView.addSubview(self.sallLabel)
        self.sallLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.titleLabel.snp.right)
            make.centerY.equalTo(self.shopNameLabel.snp.centerY)
        }
        
        self.contentView.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.bottom.equalTo(self.shopNameLabel.snp.top).offset(-6)
        }
        
        self.contentView.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    /// cell 数据
    /// - Parameters:
    ///   - cellData: cellData description
    ///   - cellType: cellType description 类型
    func reloadGoodCellData(cellData: MMCategoryPublicGoodModel, cellType: Int = 0) {
        
        let titleAttributed = NSMutableAttributedString(string: cellData.title ?? cellData.skuName ?? "", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.hexColor(0x333333)])
        
        
        // 将Data转化成图片
        let iconImageV = UIImageView()
        iconImageV.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        if cellType == 0 {
            iconImageV.image = UIImage(data: Data(base64Encoded: cellData.shopType == 0 ? kGlobalTaoBaoIcon : kGlobalTmallIcon)!)
        } else if cellType == 1 {
            iconImageV.image = UIImage(data: Data(base64Encoded: kGlobalJdIcon)!)
        } else {
            iconImageV.setImageWithURL("https://cmsstaticv2.ffquan.cn/img/dy.83050328.png")
        }
        
        
        let _imageAtt = NSTextAttachment()
        _imageAtt.image = iconImageV.image
        _imageAtt.bounds = CGRect(x: 0, y: 0, width: 14, height: 14)
        if #available(iOS 15.0, *) {
            _imageAtt.lineLayoutPadding = 4
        } else {
            // Fallback on earlier versions
        }
        titleAttributed.insert(NSMutableAttributedString(attachment: _imageAtt), at: 0)
        titleLabel.attributedText = titleAttributed
        
        
        var priceString: String = ""
        if cellType == 0 {
            self.goodImageV.setImageWithURL(cellData.mainPic)
            self.sallLabel.text = "已售: \(cellData.monthSales.formatUsingAbbrevation())"
            priceString = "折后价 ¥: \(cellData.actualPrice)"
        } else if cellType == 1 {
            self.goodImageV.setImageWithURL(cellData.imageUrlList?[0])
            self.sallLabel.text = "已售: \(cellData.inOrderCount30Days ?? 0)"
            priceString = "¥: \(cellData.lowestPrice ?? 0.00)"
        } else {
            
            self.goodImageV.setImageWithURL(cellData.cover)
            
            self.sallLabel.text = "已售: \(cellData.sales ?? 0)"
            priceString = "¥: \(cellData.price)"
        }
         
        let attributedPriceText = NSMutableAttributedString(string: priceString, attributes: [.font: UIFont.df_getCustomFontType(with: .Medium, fontSize: 18)!, .foregroundColor: UIColor.hexColor(0xf21724)])
        let nsString = NSString(string: attributedPriceText.string)
        attributedPriceText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0x999999)], range: nsString.range(of: "¥:"))
        attributedPriceText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0x999999)], range: nsString.range(of: "折后价 ¥:"))
        self.priceLabel.attributedText = attributedPriceText
        
        self.shopNameLabel.text = "\(cellData.shopName ?? "")"
        
    }
    
    private lazy var goodImageV: UIImageView = {
        let _v = UIImageView()
        _v.contentMode = .scaleAspectFill
        _v.layer(radius: 6, borderWidth: 0.0, borderColor: UIColor.white)
        return _v
    }()
    
    private lazy var titleLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0x333333)
        _lab.font = UIFont.systemFont(ofSize: 14)
        _lab.textAlignment = .left
        _lab.lineBreakMode = .byCharWrapping
        _lab.preferredMaxLayoutWidth = (kScreenWidth - 120)
        _lab.numberOfLines = 2
        _lab.lineBreakMode = .byTruncatingTail
        return _lab
    }()
    
    lazy var shopNameLabel: MMPaddingLabel = {
        let _lab = MMPaddingLabel()
        _lab.backgroundColor = UIColor.hexColor(0xF5F7F9)
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 10)
        _lab.textColor = UIColor.hexColor(0x333333)
        _lab.textInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        _lab.layer(radius: 4, borderWidth: 0.0, borderColor: UIColor.hexColor(0xF5F7F9))
        return _lab
    }()
    
    private lazy var sallLabel: UILabel = {
        let _lab = UILabel()
        _lab.textAlignment = .right
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 12)
        _lab.textColor = UIColor.hexColor(0x666666)
        return _lab
    }()
    
    private lazy var priceLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0xf21724)
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 17)
        _lab.textAlignment = .left
        return _lab
    }()
    
    private lazy var lineView: UIView = {
        let _v = UIView()
        _v.backgroundColor = UIColor.hexColor(0xF1F1F1)
        return _v
    }()
}
