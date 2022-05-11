//
//  MMPreferentMainTableCell.swift
//  Mall
//
//  Created by iOS on 2022/4/14.
//

import UIKit
import YYKit

class MMPreferentMainTableCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.dynamicColor(UIColor.hexColor(0xffffff), darkColor: UIColor.hexColor(0x1A1A1A))
        self.layer(radius: 8, borderWidth: 0.0, borderColor: UIColor.dynamicColor(UIColor.hexColor(0xffffff), darkColor: UIColor.hexColor(0x1A1A1A)))
        
        self.setUI()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var frame: CGRect {
        didSet {
            var newframe = frame
            newframe.origin.x += 12
            newframe.size.width -= 24
            newframe.origin.y += 8
            newframe.size.height -= 16
            super.frame = newframe
        }
    }
    
    
    private func setUI() {
        
        self.contentView.addSubview(self.headImagV)
        self.headImagV.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(12)
            make.top.equalTo(self.contentView.snp.top).offset(14)
            make.width.height.equalTo(44)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImagV.snp.right).offset(8)
            make.bottom.equalTo(self.headImagV.snp.centerY)
        }
        
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.bottom.equalTo(self.headImagV.snp.bottom)
        }
        
        self.contentView.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.headImagV.snp.bottom).offset(8)
            make.left.equalTo(self.headImagV.snp.left)
            make.right.equalTo(self.contentView.snp.right).offset(-12)
        }
        
        self.contentView.addSubview(self.goodImageV)
        self.goodImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImagV.snp.left)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(-8)
            make.width.height.equalTo(100)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-12)
        }

        self.contentView.addSubview(self.copysButton)
        self.copysButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-12)
            make.bottom.equalTo(self.goodImageV.snp.bottom)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
    }
    
    public var item: MMPreferentMainModel? {
        didSet {
            guard let item = item else { return }
            
            self.headImagV.sd_setImage(with: URL(string: item._platformTypeIcon), placeholderImage: kGlobalDefultImage)
            self.titleLabel.text = "\(item.platform ?? "")"
            
            self.timeLabel.text = "\(item.createTime ?? item.updateTime ?? "")"
            
            self.goodImageV.sd_setImage(with: URL(string: item.picUrls ?? ""), placeholderImage: kGlobalDefultImage)
            
            var urls: [String] = []
            let urlsString = "\(item.content ?? "")\n"
            let detector = try? NSDataDetector.init(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector?.matches(in: urlsString, options: [.reportProgress], range: NSRange(location: 0, length: urlsString.count))
            for match in matches! {
                if match.resultType == .link {
                    if let url = match.url {
                        //这里获取到的url是经过encode处理的
                        urls.append(url.absoluteString)
                    }
                }
            }
            
            let attribbutes = NSMutableAttributedString(string: urlsString)
            attribbutes.font = UIFont.df_getCustomFontType(with: .Regular, fontSize: 16)
            attribbutes.lineSpacing = 4;
            attribbutes.color = UIColor.hexColor(0x666666)
            
            if urls.count > 0 {
                let nsString = NSString(string: attribbutes.string)
                urls.forEach { (keyVal) in
                    attribbutes.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.hexColor(0xf21724), NSAttributedString.Key.font: UIFont.df_getCustomFontType(with: .Semibold, fontSize: 17) ?? UIFont.systemFont(ofSize: 17)], range:nsString.range(of: keyVal))
                    let hightText = YYTextHighlight()
                    hightText.tapAction = { view, text, range, rect in
                        UIApplication.shared.open(URL(string: keyVal)!, options: [:], completionHandler: nil)
                        return
                    }
                    attribbutes.setTextHighlight(hightText, range: nsString.range(of: keyVal))
                }
            }
            self.contentLabel.attributedText = attribbutes
        }
    }
    
    
    private func bind() {
        //self.copysButton.rx.tap.subscribe(
    }
    
    private lazy var headImagV: UIImageView = {
        let _v = UIImageView()
        _v.image = kGlobalDefultImage
        _v.layer(radius: 22, borderWidth: 0, borderColor: UIColor.white)
        return _v
    }()
    
    private lazy var titleLabel: UILabel = {
        let _lab = UILabel()
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 15)
        _lab.textColor = UIColor.hexColor(0x333333)
        _lab.textAlignment = .left
        return _lab
    }()
    
    private lazy var timeLabel: UILabel = {
        let _lab = UILabel()
        _lab.font = UIFont.df_getCustomFontType(with: .DefaultFont, fontSize: 12)
        _lab.textAlignment = .left
        _lab.textColor = UIColor.hexColor(0x999999)
        return _lab
    }()
    
    private lazy var contentLabel: YYLabel = {
        let _lab = YYLabel()
        _lab.numberOfLines = 0
        _lab.backgroundColor = .white
        _lab.lineBreakMode = .byWordWrapping
        _lab.textContainerInset = UIEdgeInsets.init(top: 5, left: 12, bottom: 10, right: 12)
        _lab.preferredMaxLayoutWidth = kScreenWidth - 120
        _lab.ignoreCommonProperties = false
        _lab.textAlignment = .left
        _lab.textVerticalAlignment = .top
        _lab.font = UIFont.df_getCustomFontType(with: .Regular, fontSize: 17)
        _lab.lineBreakMode = .byCharWrapping
        return _lab
    }()
    
    private lazy var goodImageV: UIImageView = {
        let _v = UIImageView()
        _v.image = kGlobalDefultImage
        _v.layer(radius: 6, borderWidth: 0, borderColor: UIColor.white)
        return _v
    }()

    private lazy var copysButton: UIButton = {
        let _btn = UIButton()
        _btn.setTitle("复制口令或链接", for: .normal)
        _btn.setTitle("复制口令或链接", for: .selected)
        _btn.setTitle("复制口令或链接", for: .highlighted)
        _btn.setTitleColor(UIColor.white, for: .normal)
        _btn.setTitleColor(UIColor.white, for: .selected)
        _btn.setTitleColor(UIColor.white, for: .highlighted)
        _btn.titleLabel?.font = UIFont.df_getCustomFontType(with: .Regular, fontSize: 12)
        _btn.backgroundColor = UIColor.hexColor(0xf21724)
        _btn.layer(radius: 8, borderWidth: 0, borderColor: UIColor.hexColor(0xf21724))
        return _btn
    }()
}
