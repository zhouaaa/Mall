//
//  MMHomeCouponPageTableCell.swift
//  Mall
//
//  Created by iOS on 2022/5/13.
//

import UIKit
import Pastel

class MMHomeCouponPageTableCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.dynamicColor(UIColor.hexColor(0xffffff), darkColor: UIColor.hexColor(0x1A1A1A))
        self.layer(radius: 8, borderWidth: 0.0, borderColor: UIColor.dynamicColor(UIColor.hexColor(0xffffff), darkColor: UIColor.hexColor(0x1A1A1A)))
        
        self.setUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var frame: CGRect {
        didSet {
            var newframe = frame
            newframe.origin.x += 12
            newframe.size.width -= 24
            newframe.origin.y += 6
            newframe.size.height -= 12
            super.frame = newframe
        }
    }
    
    private func setUI() {
        
        self.contentView.addSubview(self.goodImageV)
        self.goodImageV.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(self.goodImageV.snp.height)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.goodImageV.snp.right).offset(STtrans(8))
            make.right.equalTo(self.contentView.snp.right).offset(-STtrans(8))
            make.top.equalTo(self.goodImageV.snp.top).offset(STtrans(8))
        }
        
        self.contentView.addSubview(self.bghotView)
        
        self.contentView.addSubview(self.buyLabel)
        self.buyLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-STtrans(12))
            make.bottom.equalTo(self.goodImageV.snp.bottom).offset(-STtrans(8))
            make.height.equalTo(STtrans(28.7))
            make.width.equalTo(self.bghotView.snp.height).multipliedBy(82.8/28.7)
        }
        
        self.bghotView.snp.makeConstraints { (make) in
            make.left.equalTo(self.goodImageV.snp.right).offset(STtrans(8))
            make.right.equalTo(self.buyLabel.snp.left).offset(4)
            make.bottom.equalTo(self.buyLabel.snp.bottom)
            make.height.equalTo(STtrans(24.28))
        }
        self.bghotView.startPastelPoint = .topRight
        self.bghotView.endPastelPoint = .bottomLeft
        self.bghotView.animationDuration = 3.0
        self.bghotView.setColors([UIColor.hexColor(0xfff0dc), UIColor.hexColor(0xffdcbd)])
        self.bghotView.startAnimation()
        
        
        self.bghotView.addSubview(self.seallLabel)
        self.seallLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(self.bghotView.snp.centerX).offset(9)
        }
        
        self.bghotView.addSubview(self.hotImageV)
        self.hotImageV.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.bghotView.snp.centerY)
            make.right.equalTo(self.seallLabel.snp.left).offset(-4)
            make.width.equalTo(10)
            make.height.equalTo(12)
        }
        
        self.contentView.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.buyLabel.snp.top).offset(-4)
            make.left.equalTo(self.goodImageV.snp.right).offset(STtrans(8))
        }
        
        self.contentView.addSubview(self.priceLineLabel)
        self.priceLineLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.priceLabel.snp.bottom)
            make.left.equalTo(self.priceLabel.snp.right).offset(4)
        }
        
        self.contentView.addSubview(self.quanTitleLabel)
        self.quanTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.goodImageV.snp.right).offset(STtrans(8))
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
        }
        
        self.contentView.addSubview(self.quanLabel)
        self.quanLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.quanTitleLabel.snp.right).offset(-2)
            make.top.equalTo(self.quanTitleLabel.snp.top)
            make.bottom.equalTo(self.quanTitleLabel.snp.bottom)
        }
        self.quanLabel.bringSubviewToFront(self.quanTitleLabel)
        
    }
    
    func handleCellData(itemModel: MMHomeLargeCouponGoodItemModel)  {
        
        self.goodImageV.sd_setImage(with: URL(string: itemModel.mainPic ?? ""), placeholderImage: kGlobalDefultImage)
        
        let titleAttributed = NSMutableAttributedString(string:" \(itemModel.dtitle ?? itemModel.title ?? "")", attributes: [
            .font: UIFont.df_getCustomFontType(with: .Medium, fontSize: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.hexColor(0x333333)])
        
        if itemModel.shopType != 0 {
            let textAttachment = NSTextAttachment()
            let attTmImage = UIImage(data: Data(base64Encoded: kGlobalTmallIcon)!)
            textAttachment.image = attTmImage
            textAttachment.bounds = CGRect(x: 0, y: 0, width: 12, height:  12)
            let attImageString = NSMutableAttributedString(attachment: textAttachment)
            titleAttributed.insert(attImageString, at: 0)
        }
        
        self.titleLabel.attributedText = titleAttributed
        
        
        let priceString: String = "¥\(itemModel.actualPrice)活动价"
        let attributedPriceText = NSMutableAttributedString(string: priceString, attributes: [.font: UIFont.df_getCustomFontType(with: .Regular, fontSize: 12) ?? UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0xf21724)])
        let nsString = NSString(string: attributedPriceText.string)
        attributedPriceText.addAttributes([.font: UIFont.df_getCustomFontType(with: .Semibold, fontSize: 18) ?? UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.hexColor(0xf21724)], range: nsString.range(of: "\(itemModel.actualPrice)"))
        self.priceLabel.attributedText = attributedPriceText
        
        let attributedoriginalPriceText = NSMutableAttributedString(string: "¥\(itemModel.originalPrice)", attributes: [.font: UIFont.df_getCustomFontType(with: .Regular, fontSize: 14) ?? UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.hexColor(0x999999), .strikethroughStyle: NSUnderlineStyle.single.rawValue])
        self.priceLineLabel.attributedText = attributedoriginalPriceText
        
        self.seallLabel.text = "热销: \(itemModel.monthSales.formatUsingAbbrevation())件"
        
        self.quanLabel.text = "\(itemModel.couponPrice)元"
        
    }
    
   private lazy var goodImageV: UIImageView = {
        let _v = UIImageView(image: kGlobalDefultImage)
        _v.layer(radius: 4, borderWidth: 0.0, borderColor: UIColor.white)
        return _v
    }()
    
    private lazy var logoImageV: UIImageView = {
        let _v = UIImageView()
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
    
    private lazy var priceLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0xf21724)
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 17)
        _lab.textAlignment = .left
        return _lab
    }()
    
    private lazy var priceLineLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0x999999)
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 14)
        _lab.textAlignment = .left
        return _lab
    }()

    private lazy var bghotView: PastelView = {
        let _v = PastelView()
        _v.layer(radius: 4, borderWidth: 0.0, borderColor: UIColor.white)
        return _v
    }()
    
    private lazy var hotImageV: UIImageView = {
        let _v = UIImageView(image: UIImage(data: Data(base64Encoded: kGlobalHotIcon)!))
        return _v
    }()
    
    private lazy var seallLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0xc4310b)
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 12)
        _lab.textAlignment = .center
        return _lab
    }()
    
   
    private lazy var buyLabel: MMPaddingLabel = {
        let _lab = MMPaddingLabel()
        _lab.backgroundColor = UIColor.hexColor(0x7112b7)
        _lab.font = UIFont.df_getCustomFontType(with: .Regular, fontSize: 13)
        _lab.textColor = UIColor.hexColor(0xffffff)
        _lab.textInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
       _lab.textAlignment = .center
       _lab.text = "马上抢"
        _lab.layer(radius: 4, borderWidth: 0.0, borderColor: UIColor.hexColor(0x7112b7))
        return _lab
    }()
    
    private lazy var quanTitleLabel: MMPaddingLabel = {
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
    
    private lazy var quanLabel: MMPaddingLabel = {
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
