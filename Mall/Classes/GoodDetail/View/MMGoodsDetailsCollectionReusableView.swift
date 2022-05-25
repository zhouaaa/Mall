//
//  MMGoodsDetailsCollectionReusableView.swift
//  Mall
//
//  Created by iOS on 2022/5/18.
//

import UIKit
import Pastel


class MMGoodsDetailsCollectionReusableView: UICollectionReusableView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        self.markUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func markUI() {
        
        self.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(STtrans(12))
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(4)
            make.height.equalTo(STtrans(16))
        }
        self.lineView.startPastelPoint = .topLeft
        self.lineView.endPastelPoint = .bottomRight
        self.lineView.animationDuration = 3.0
        self.lineView.setColors([UIColor.hexColor(0xff3643), UIColor.hexColor(0xffcccf)])
        self.lineView.startAnimation()
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.lineView.snp.right).offset(4)
            make.centerY.equalTo(self.lineView.snp.centerY)
        }
        
        self.addSubview(self.recomLabel)
        self.recomLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX).offset(10)
        }
        
        self.addSubview(self.cireleImage)
        self.cireleImage.snp.makeConstraints { (make) in
            make.right.equalTo(self.recomLabel.snp.left).offset(-4)
            make.centerY.equalTo(self.recomLabel.snp.centerY)
            make.width.equalTo(16.63)
            make.height.equalTo(14.55)
        }
        
        
    }
    
    
    func detailSection(indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            self.titleLabel.isHidden = false
            self.lineView.isHidden = false
            self.cireleImage.isHidden = true
            self.recomLabel.isHidden = true
            self.backgroundColor = .white
        case 2:
            self.titleLabel.isHidden = true
            self.lineView.isHidden = true
            self.cireleImage.isHidden = false
            self.recomLabel.isHidden = false
            self.backgroundColor = .clear
        default:
            self.titleLabel.isHidden = true
            self.lineView.isHidden = true
            self.cireleImage.isHidden = true
            self.recomLabel.isHidden = true
            self.backgroundColor = .clear
        }
    }
    
    
    private lazy var lineView: PastelView = {
        let _v = PastelView()
        _v.layer(radius: 2, borderWidth: 0.0, borderColor: UIColor.white)
        return _v
    }()
    
   private lazy var titleLabel: UILabel = {
        let _lab = UILabel()
       _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 14)
       _lab.textColor = UIColor.hexColor(0x000000)
       _lab.textAlignment = .left
       _lab.text = "商品详情"
        return _lab
    }()
    
    private lazy var recomLabel: UILabel = {
         let _lab = UILabel()
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 14)
        _lab.textColor = UIColor.hexColor(0x000000)
        _lab.textAlignment = .center
        _lab.text = "为你推荐"
         return _lab
     }()
    
    private lazy var cireleImage: UIImageView = {
        let _v = UIImageView()
        _v.image = UIImage(data: Data(base64Encoded: likeString)!)
        return _v
    }()
    
    private let likeString: String = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAcCAYAAAAAwr0iAAAAAXNSR0IArs4c6QAABFlJREFUSEutVk1oXFUU/r77RtqJprOxS3dCUdQqWUi1i2IV7A/5IU4MJFCSRVujKVpcFIR0UiMRQqSVSOwsmmIbiDNgWxu6aBSCXbkQqaVFFFHESnChGEtkknn3yHnv3clM5udNW2eVl3vvOd/5vu+ce4noJ5mMwfHjQlLkypVNsPYJGPMogK0ACvD9JXjeLe7d+5Mecfvd+eDcpUut8LynQT4C4GGQd2DtbZDXuW/fkogQo6NkJmNL54JgugAgCDI/n0axOATgGRiT0kVdgIhu/A3AVwDeZ2fnDcnlPPb0+AHgtbXXAfQBeBzAZg2rISFSBPkzrL0MYybZ0fG7gncg6D7k/PktSCZPQ6Q3OgxY64MBNkVnAJjg29oCjHmH3d2TksttAzkLsq3OOS+qVsEsATjAdPqqAx9El5mZzUgmL0PkRYj4wQFjDJQZTajVh1QpdRZkAqAFJAtjnoe1TwbnSGVLE4aMlfSNYoZr/8L3e9jfPx+ACOKeO/cBRN4CUASQiJKtBwgZKP+WSBplZf3v8qSV+10RWoCyuATf38GBgV8oZ848C5EvADxU0q0ydb0vLdGVqUCa/YVFkqc5OHiYks1OwNq3ASj1Tq/qYLUrajZp+T7HghrzBcrU1HWIPBXop9qt6xbSrrSW+6DUPxWSVAMpP1cN3hXbQTl5chkirRWmqdb8Xiqtf0ZbU2VIJA5TJibuAHiwCsD/m3JjNJ0NCRgzRBkfvwVrH6tpwEYSxAFsfDaUQKSTcuLERxDRydfYhHEJy1uwsYShCYHbMGY3ZWRkN6xdKIsf4644JLHrbtZ8yrGx3nAQHTv2GUS6Kli4H/odA9UdFHYaqdP0OY6Pfx0COHp0O4BrAForvBDXho1brRYVbgid4uTkm8E9JOm0x3zelyNHhiHy4X17ob4CzmPfoFh8idPTf0UTJrzb9XqUoaGPYe2hewLR2ITOeH+A1OTfuZyhBG7WDQ9vwspKDkB7xcVUy9XNuD6UyEJEXf8PPO8VZrNXHetB2NLkdSwcPJhCoTAHkZdBFiGiF8f6lXx3o9iHiAdyBWQfz569KJlMgpmMeiH4bbhjo1R9fVsAfAKRjiomYrustMFp/jfIfs7OzpdXXhNAIIdjIp1OgpyCtYORJxRss9dumJz8FZ7Xz7m5a7JrV4KLi6XK6wJwIAJ61JhdXaMQGYkeINrHcSBC2YBvYUwvL1z4oVblDQE4YyKTCV6w0t5+AL5/CkAqYqPyuRZet+FLVw1Hfo6WlgHm8382Sl7lgY3yqoeRTptgTuzfvwNrazOwdlvkC6U4fPuRajZNrEjGkEq9y3x+tfz1W886Tc390rDas2crVlen4fvdwQPGWoEx+ibUm017/BAXFy/qfuTzVnsnzrNNAQiYdROzre0BtLS8AZH3IKJG1eUvkUy+xoWFH+8meawEDSXZuXM7CoVXkUh8j+XlOd68uRqndy02mmagNLDUF5E5G/0vjnq3/h/gPz3gXRJEVAAAAABJRU5ErkJggg=="
    
}
