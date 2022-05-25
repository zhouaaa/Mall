//
//  MMGoodsDetailsPriceCollectionCell.swift
//  Mall
//
//  Created by iOS on 2022/5/25.
//

import UIKit

class MMGoodsDetailsPriceCollectionCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.markUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func markUI() {
    
        self.contentView.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(12)
            make.top.equalTo(self.contentView.snp.top).offset(16)
        }
        
        self.contentView.addSubview(self.sallLabel)
        self.sallLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-12)
            make.centerY.equalTo(self.priceLabel.snp.centerY)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(12)
            make.top.equalTo(self.priceLabel.snp.bottom).offset(10)
            make.width.lessThanOrEqualTo(kScreenWidth - 28)
        }
        
        self.contentView.addSubview(self.coupLeftImageV)
        self.contentView.addSubview(self.coupRightImageV)
        self.coupLeftImageV.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-16)
            make.left.equalTo(self.contentView.snp.left).offset(12)
            make.right.equalTo(self.coupRightImageV.snp.left)
            make.height.equalTo(self.coupLeftImageV.snp.width).multipliedBy(67.59/243.36)
        }
        
        self.coupRightImageV.snp.makeConstraints { (make) in
            make.top.equalTo(self.coupLeftImageV.snp.top)
            make.right.equalTo(self.contentView.snp.right).offset(-12)
            make.left.equalTo(self.coupLeftImageV.snp.right)
            make.height.equalTo(self.coupLeftImageV.snp.height)
            make.width.equalTo(self.coupLeftImageV.snp.width).multipliedBy(125.84/243.36)
        }
        
        self.coupRightImageV.addSubview(self.voucherNowLabel)
        self.voucherNowLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.coupRightImageV.snp.centerY)
            make.centerX.equalTo(self.coupRightImageV.snp.centerX)
        }
        
        
        self.coupLeftImageV.addSubview(self.coupLabel)
        self.coupLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.coupLeftImageV.snp.left).offset(24)
            make.centerY.equalTo(self.self.coupLeftImageV.snp.centerY)
        }
        
        self.coupLeftImageV.addSubview(self.coupTimeLabel)
        self.coupTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.coupLabel.snp.right).offset(STtrans(24))
            make.centerY.equalTo(self.coupLabel.snp.centerY)
            make.right.equalTo(self.coupLeftImageV.snp.right).offset(-STtrans(12))
        }
        
    }
    
    
    func setItemPriceModel(itemModel: MMCategoryPublicGoodModel) {
        
        self.sallLabel.text = "已售: \(itemModel.monthSales.formatUsingAbbrevation())件"
        
        
        let priceString: String = "¥\(itemModel.actualPrice) 原价¥\(itemModel.originalPrice)"
        let attributedPriceText = NSMutableAttributedString(string: priceString, attributes: [.font: UIFont.df_getCustomFontType(with: .Regular, fontSize: 12) ?? UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0xf21724)])
        let nsString = NSString(string: attributedPriceText.string)
        attributedPriceText.addAttributes([.font: UIFont.df_getCustomFontType(with: .Semibold, fontSize: 20)!, .foregroundColor: UIColor.hexColor(0xf21724)], range: nsString.range(of: "\(itemModel.actualPrice)"))
        
        attributedPriceText.addAttributes([.font: UIFont.df_getCustomFontType(with: .Regular, fontSize: 12) ?? UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0x999999), .strikethroughStyle: NSUnderlineStyle.single.rawValue], range: nsString.range(of: "原价¥\(itemModel.originalPrice)"))
        
        self.priceLabel.attributedText = attributedPriceText
        
        
        let titleAttributed = NSMutableAttributedString(string: " \(itemModel.dtitle ?? itemModel.title ?? "")", attributes: [
            .font: UIFont.df_getCustomFontType(with: .Semibold, fontSize: 20) ?? UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.hexColor(0x333333)])
        
        let textAttachment = NSTextAttachment()
        var attTmImage = UIImage(data: Data(base64Encoded: kGlobalTaoBaoIcon)!)
        if itemModel.shopType == 1 {
            attTmImage = UIImage(data: Data(base64Encoded: itemModel.tchaoshi ? kGlobalTchaoshiIcon : kGlobalTmallIcon)!)
        }
        textAttachment.image = attTmImage
        textAttachment.bounds = CGRect(x: 0, y: 0, width: 14, height:  14)
        let attImageString = NSMutableAttributedString(attachment: textAttachment)
        titleAttributed.insert(attImageString, at: 0)
        self.titleLabel.attributedText = titleAttributed
        
        
        let couponString: String = "¥ \(itemModel.couponPrice)"
        let attributedCouponText = NSMutableAttributedString(string: couponString, attributes: [.font: UIFont.df_getCustomFontType(with: .Regular, fontSize: 12) ?? UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0xf21724)])
        let nssString = NSString(string: attributedCouponText.string)
        attributedCouponText.addAttributes([.font: UIFont.df_getCustomFontType(with: .Semibold, fontSize: 20)!, .foregroundColor: UIColor.hexColor(0xf21724)], range: nssString.range(of: "\(itemModel.couponPrice)"))
        self.coupLabel.attributedText = attributedCouponText
        
        
        let startTimeDate = Date.dateFromString(itemModel.couponStartTime ?? "", withFormatter: "yyyy-MM-dd")
        let endTimeDate = Date.dateFromString(itemModel.couponEndTime ?? "", withFormatter: "yyyy-MM-dd")
        
        
        self.coupTimeLabel.text = "优惠券使用期限\n\(Date.stringFromDate(startTimeDate ?? Date(), format: "yyyy-MM-dd"))-\(Date.stringFromDate(endTimeDate ?? Date(), format: "yyyy-MM-dd"))"
        
    }
    
    private lazy var priceLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0xf21724)
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 17)
        _lab.textAlignment = .left
        return _lab
    }()
    
    private lazy var sallLabel: UILabel = {
        let _lab = UILabel()
        _lab.textAlignment = .right
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 12)
        _lab.textColor = UIColor.hexColor(0x666666)
        return _lab
    }()
    
    private lazy var titleLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0x333333)
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 20)
        _lab.textAlignment = .left
        _lab.lineBreakMode = .byCharWrapping
        _lab.numberOfLines = 2
        _lab.lineBreakMode = .byTruncatingTail
        return _lab
    }()
    
    private lazy var coupLeftImageV: UIImageView = {
        let _v = UIImageView()
        _v.setImageWith(URL(string: "https://cmsstaticv2.ffquan.cn/img/quanleft.dcece460.png"), placeholder: kGlobalDefultImage)
        return _v
    }()
    
    private lazy var coupRightImageV: UIImageView = {
        let _v = UIImageView()
        _v.setImageWith(URL(string: "https://cmsstaticv2.ffquan.cn/img/quanright.ca29e942.png"), placeholder: kGlobalDefultImage)
        return _v
    }()
    
    private lazy var voucherNowLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0xff313e)
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 16)
        _lab.textAlignment = .center
        _lab.text = "立即领券"
        return _lab
    }()
    
    private lazy var coupLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0xff313e)
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 20)
        _lab.textAlignment = .left
        return _lab
    }()
    
    private lazy var coupTimeLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0xff313e)
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 12)
        _lab.textAlignment = .left
        _lab.numberOfLines = 3
        return _lab
    }()
    
}
