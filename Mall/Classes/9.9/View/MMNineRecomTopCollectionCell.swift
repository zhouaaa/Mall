//
//  MMNineRecomTopCollectionCell.swift
//  Mall
//
//  Created by iOS on 2022/5/17.
//

import UIKit
import Pastel


class MMNineRecomTopCollectionCell: UICollectionViewCell {
    
    
    var MMNineRecomTopCollectionCellBlock:((MMNineTopGoodModel)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
   
    func reloadTopCellListData(listModel: [MMNineTopGoodModel]) {
        self.dataLists = listModel
        self.collectionView.reloadData()
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        flowlayout.sectionInset = UIEdgeInsets(top: STtrans(12), left: STtrans(12), bottom: 0, right: STtrans(12))
        flowlayout.minimumLineSpacing = STtrans(12)
        flowlayout.minimumInteritemSpacing = 0
        let _v = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
        _v.showsVerticalScrollIndicator = false
        _v.showsHorizontalScrollIndicator = false
        _v.delegate = self
        _v.dataSource = self
        _v.backgroundColor = UIColor.clear
        _v.register(MMNineRecomTopItemCollectionCell.self, forCellWithReuseIdentifier: "MMNineRecomTopItemCollectionCell")
        return _v
    }()
    
    private var dataLists = [MMNineTopGoodModel]()
}

extension MMNineRecomTopCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MMNineRecomTopItemCollectionCell", for: indexPath) as! MMNineRecomTopItemCollectionCell
       
        if self.dataLists.count > indexPath.row {
            cell.handleCellModel(itemModel: self.dataLists[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.dataLists.count > indexPath.row {
            self.MMNineRecomTopCollectionCellBlock?(self.dataLists[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = (collectionView.height - STtrans(12))
        return CGSize(width: cellHeight*(121.43/187.11), height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
}


class MMNineRecomTopItemCollectionCell: UICollectionViewCell {
    
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
        
        self.contentView.addSubview(self.googImageV)
        self.googImageV.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(self.googImageV.snp.width)
        }
        
        self.contentView.addSubview(self.bgSeallView)
        self.bgSeallView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.googImageV.snp.bottom)
            make.left.equalTo(self.googImageV.snp.left).offset(STtrans(4))
            make.right.equalTo(self.googImageV.snp.right).offset(-STtrans(4))
            make.height.equalTo(STtrans(20))
        }
        self.bgSeallView.startPastelPoint = .left
        self.bgSeallView.endPastelPoint = .right
        self.bgSeallView.animationDuration = 3.0
        self.bgSeallView.setColors([UIColor.hexColor(0xffbe50), UIColor.hexColor(0xff570c)])
        self.bgSeallView.startAnimation()
        
        self.bgSeallView.addSubview(self.seallLabel)
        self.seallLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.googImageV.snp.left).offset(STtrans(2))
            make.right.equalTo(self.googImageV.snp.right).offset(-STtrans(2))
            make.top.equalTo(self.bgSeallView.snp.bottom).offset(STtrans(4))
        }
        
        self.contentView.addSubview(self.priceLabel)
        self.priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.googImageV.snp.left).offset(STtrans(2))
            make.right.equalTo(self.googImageV.snp.right).offset(-STtrans(2))
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-STtrans(2))
        }
        
    }
    
    
    func handleCellModel(itemModel: MMNineTopGoodModel) {
    
        self.googImageV.sd_setImage(with: URL(string: itemModel.pic ?? ""), placeholderImage: kGlobalDefultImage)
        
        self.seallLabel.text = "疯抢 \(itemModel.xiaoliang.formatUsingAbbrevation())件"
        
        self.titleLabel.text = "\(itemModel.dtitle ?? itemModel.title ?? "")"
        
        let priceString: String = "¥\(itemModel.jiage) ¥\(itemModel.yuanjia)"
        let attributedPriceText = NSMutableAttributedString(string: priceString, attributes: [.font: UIFont.df_getCustomFontType(with: .Regular, fontSize: 12) ?? UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0xf21724)])
        let nsString = NSString(string: attributedPriceText.string)
        attributedPriceText.addAttributes([.font: UIFont.df_getCustomFontType(with: .Semibold, fontSize: 17) ?? UIFont.boldSystemFont(ofSize: 17), .foregroundColor: UIColor.hexColor(0xf21724)], range: nsString.range(of: "\(itemModel.jiage)"))
        
        attributedPriceText.addAttributes([.font: UIFont.df_getCustomFontType(with: .Regular, fontSize: 12) ?? UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.hexColor(0x999999), .strikethroughStyle: NSUnderlineStyle.single.rawValue], range: nsString.range(of: "¥\(itemModel.yuanjia)"))
        
        self.priceLabel.attributedText = attributedPriceText
        
    }
    
    
    private lazy var googImageV: UIImageView = {
        let _v = UIImageView(image: kGlobalDefultImage)
        return _v
    }()
    
    private lazy var titleLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0x333333)
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 12)
        _lab.textAlignment = .center
        _lab.lineBreakMode = .byCharWrapping
        _lab.numberOfLines = 1
        _lab.lineBreakMode = .byTruncatingTail
        return _lab
    }()
    
    private lazy var priceLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0xf21724)
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 17)
        _lab.textAlignment = .center
        return _lab
    }()
    
    private lazy var bgSeallView: PastelView = {
        let _v = PastelView()
        _v.layer(radius: STtrans(10), borderWidth: 0.0, borderColor: UIColor.white)
        return _v
    }()
    
    private lazy var seallLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.white
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 12)
        _lab.textAlignment = .center
        return _lab
    }()
}
