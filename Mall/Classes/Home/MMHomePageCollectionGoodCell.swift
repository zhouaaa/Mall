//
//  MMHomePageCollectionGoodCell.swift
//  Mall
//
//  Created by iOS on 2022/3/2.
//

import UIKit


class MMHomePageCollectionGoodCell: UICollectionViewCell {
    
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
            make.top.equalTo(self.iconImageV.snp.bottom)
            make.left.equalTo(self.iconImageV.snp.left).offset(STtrans(6))
            make.right.equalTo(self.iconImageV.snp.right).offset(-STtrans(6))
        }
        
        self.contentView.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(STtrans(4))
        }
        
        self.contentView.addSubview(self.couponTitleLabel)
        self.couponTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.priceLabel.snp.left)
            make.top.equalTo(self.priceLabel.snp.bottom).offset(STtrans(4))
        }
        
        self.contentView.addSubview(self.couponLabel)
        self.couponLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.couponTitleLabel.snp.right).offset(-2)
            make.top.equalTo(self.couponTitleLabel.snp.top)
            make.bottom.equalTo(self.couponTitleLabel.snp.bottom)
        }
        self.couponLabel.bringSubviewToFront(self.couponTitleLabel)
        
        self.contentView.addSubview(self.sallLabel)
        self.sallLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.couponTitleLabel.snp.left)
            make.top.equalTo(self.couponTitleLabel.snp.bottom).offset(STtrans(4))
        }
        
    }
    
    func cellItemData(itemModel: MMHomeGoodItemModel) {
       
        self.iconImageV.setImageWithURL(itemModel.mainPic)
        
        self.sallLabel.text = "已售: \(itemModel.monthSales.formatUsingAbbrevation())"
        
        let priceString: String = "券后价 ¥ \(itemModel.actualPrice)"
        let attributedPriceText = NSMutableAttributedString(string: priceString, attributes: [.font: UIFont.df_getCustomFontType(with: .Medium, fontSize: 18)!, .foregroundColor: UIColor.hexColor(0xf21724)])
        let nsString = NSString(string: attributedPriceText.string)
        attributedPriceText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0x999999)], range: nsString.range(of: "¥:"))
        attributedPriceText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0x999999)], range: nsString.range(of: "券后价 ¥"))
        self.priceLabel.attributedText = attributedPriceText
        
        self.couponLabel.text = " \(itemModel.couponPrice) 元"
        
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
    
    
    private lazy var couponTitleLabel: MMPaddingLabel = {
        let _lab = MMPaddingLabel()
        _lab.backgroundColor = UIColor.white
        _lab.font = UIFont.df_getCustomFontType(with: .Regular, fontSize: 12)
        _lab.textColor = UIColor.hexColor(0xfe3a33)
        _lab.textInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
       _lab.textAlignment = .center
       _lab.text = "券"
        _lab.layer(radius: 2, borderWidth: 1.0, borderColor: UIColor.hexColor(0xfe3a33))
        return _lab
    }()
    
    private lazy var couponLabel: MMPaddingLabel = {
        let _lab = MMPaddingLabel()
        _lab.backgroundColor = UIColor.hexColor(0xff4f4f, 0.98)
        _lab.font = UIFont.df_getCustomFontType(with: .Regular, fontSize: 12)
        _lab.textColor = UIColor.white
        _lab.textInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 6)
       _lab.textAlignment = .center
        _lab.layer(radius: 2, borderWidth: 0.0, borderColor: UIColor.hexColor(0xff4f4f, 0.98))
        return _lab
    }()
    
}
