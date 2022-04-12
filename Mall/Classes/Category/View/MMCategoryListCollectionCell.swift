//
//  MMCategoryListCollectionCell.swift
//  Mall
//
//  Created by iOS on 2022/3/31.
//

import UIKit
import YYKit

class MMCategoryListCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        markUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func markUI() {
        
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
            iconImageV.setImageWith(NSURL(string: "https://cmsstaticv2.ffquan.cn/img/dy.83050328.png") as URL?, placeholder: kGlobalDefultImage)
        }
        
        let _imageAtt = NSAttributedString.attachmentString(withContent: iconImageV, contentMode: .scaleAspectFit, attachmentSize: iconImageV.size, alignTo: UIFont.systemFont(ofSize: 15), alignment: YYTextVerticalAlignment.center)
        titleAttributed.insert(_imageAtt, at: 0)
        titleLabel.attributedText = titleAttributed
        
        
        var priceString: String = ""
        if cellType == 0 {
            self.goodImageV.setImageWith(URL(string: cellData.mainPic ?? ""), placeholder: kGlobalDefultImage)
            self.sallLabel.text = "已售: \(cellData.monthSales ?? 0)"
            priceString = "折后价 ¥: \(cellData.actualPrice ?? 0.00)"
        } else if cellType == 1 {
            self.goodImageV.setImageWith(URL(string: cellData.imageUrlList?[0] ?? ""), placeholder: kGlobalDefultImage)
            self.sallLabel.text = "已售: \(cellData.inOrderCount30Days ?? 0)"
            priceString = "¥: \(cellData.lowestPrice ?? 0.00)"
        } else {
            self.goodImageV.setImageWith(URL(string: cellData.cover ?? ""), placeholder: kGlobalDefultImage)
            self.sallLabel.text = "已售: \(cellData.sales ?? 0)"
            priceString = "¥: \(cellData.price ?? 0.00)"
        }
         
        let attributedPriceText = NSMutableAttributedString(string: priceString, attributes: [.font: UIFont.boldSystemFont(ofSize: 17), .foregroundColor: UIColor.hexColor(0xf21724)])
        let nsString = NSString(string: attributedPriceText.string)
        attributedPriceText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0x999999)], range: nsString.range(of: "¥:"))
        attributedPriceText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0x999999)], range: nsString.range(of: "折后价 ¥:"))
        self.priceLabel.attributedText = attributedPriceText
        
        self.shopNameLabel.text = "  \(cellData.shopName ?? "")  "        
        
    }
    
    private lazy var goodImageV: UIImageView = {
        let _v = UIImageView()
        _v.contentMode = .scaleAspectFit
        return _v
    }()
    
    private lazy var titleLabel: YYLabel = {
        let _lab = YYLabel()
        _lab.textColor = UIColor.hexColor(0x333333)
        _lab.font = UIFont.systemFont(ofSize: 14)
        _lab.textAlignment = .left
        _lab.lineBreakMode = .byCharWrapping
        _lab.preferredMaxLayoutWidth = (kScreenWidth - 120)
        _lab.numberOfLines = 2
        _lab.lineBreakMode = .byTruncatingTail
        return _lab
    }()
    
    lazy var shopNameLabel: UILabel = {
        let _lab = UILabel()
        _lab.backgroundColor = UIColor.hexColor(0xF8F8FA)
        _lab.font = UIFont.systemFont(ofSize: 12)
        _lab.textColor = UIColor.hexColor(666666)
        return _lab
    }()
    
    private lazy var sallLabel: UILabel = {
        let _lab = UILabel()
        _lab.textAlignment = .right
        _lab.font = UIFont.systemFont(ofSize: 12)
        _lab.textColor = UIColor.hexColor(0x666666)
        return _lab
    }()
    
    private lazy var priceLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0xf21724)
        _lab.font = UIFont.boldSystemFont(ofSize: 17)
        _lab.textAlignment = .left
        return _lab
    }()
    
}
