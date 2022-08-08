//
//  MMNinePageCollectionGoodCell.swift
//  Mall
//
//  Created by iOS on 2022/5/12.
//

import UIKit



class MMNinePageCollectionGoodCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer(radius: 6, borderWidth: 0.0, borderColor: UIColor.white)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        self.contentView.addSubview(self.iconImageV)
        self.iconImageV.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(self.iconImageV.snp.width)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.iconImageV.snp.bottom).offset(2)
            make.left.equalTo(self.iconImageV.snp.left).offset(6)
            make.right.equalTo(self.iconImageV.snp.right).offset(-6)
        }
        
        self.contentView.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(2)
        }
        
        
        self.contentView.addSubview(self.couponLabel)
        self.couponLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.iconImageV.snp.right).offset(-6)
            make.centerY.equalTo(self.priceLabel.snp.centerY)
        }
        
        self.contentView.addSubview(self.couponImageV)
        self.couponImageV.snp.makeConstraints { (make) in
            make.right.equalTo(self.couponLabel.snp.left).offset(-2)
            make.centerY.equalTo(self.couponLabel.snp.centerY)
            make.width.height.equalTo(20)
        }
        
        self.contentView.addSubview(self.sallLabel)
        self.sallLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.priceLabel.snp.left)
            make.top.equalTo(self.priceLabel.snp.bottom).offset(2)
        }
        
    }
    
    func cellItemData(itemModel: MMNineGoodItemModel) {
       
    
        self.iconImageV.setImageWithURL(itemModel.pic)
        self.sallLabel.text = "已售: \(itemModel.xiaoliang.formatUsingAbbrevation())"
        
        let priceString: String = "券后价 ¥ \(itemModel.jiage)"
        let attributedPriceText = NSMutableAttributedString(string: priceString, attributes: [.font: UIFont.df_getCustomFontType(with: .Medium, fontSize: 18)!, .foregroundColor: UIColor.hexColor(0xf21724)])
        let nsString = NSString(string: attributedPriceText.string)
        attributedPriceText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0x999999)], range: nsString.range(of: "¥:"))
        attributedPriceText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0x999999)], range: nsString.range(of: "券后价 ¥"))
        self.priceLabel.attributedText = attributedPriceText
        
        self.couponLabel.text = " \(itemModel.quanJine) 元"
        
        let titleAttributed = NSMutableAttributedString(string: itemModel.dtitle ?? itemModel.title ?? "", attributes: [
            .font: UIFont.df_getCustomFontType(with: .Medium, fontSize: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.hexColor(0x333333)])
        
        let textAttachment = NSTextAttachment()
        let attTmImage = UIImage(data: Data(base64Encoded: kGlobalTmallIcon)!)
        textAttachment.image = attTmImage
        textAttachment.bounds = CGRect(x: 0, y: 0, width: 12, height:  12)
        let attImageString = NSMutableAttributedString(attachment: textAttachment)
        titleAttributed.insert(attImageString, at: 0)
        self.titleLabel.attributedText = titleAttributed
        
    }
    
    
    private lazy var iconImageV: UIImageView = {
        let _v = UIImageView()
        _v.image = kGlobalDefultImage
        return _v
    }()
    
    private lazy var titleLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0x333333)
        _lab.font = UIFont.systemFont(ofSize: 14)
        _lab.textAlignment = .left
        _lab.lineBreakMode = .byCharWrapping
        _lab.numberOfLines = 2
        _lab.lineBreakMode = .byTruncatingTail
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
    
   private lazy var couponLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0x333333)
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 14)
        _lab.textAlignment = .left
        return _lab
    }()
 
    private lazy var couponImageV: UIImageView = {
        let _v = UIImageView()
        _v.image = UIImage(named: "comm_coupon")
        return _v
    }()
    
}
