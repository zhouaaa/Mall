//
//  MMNineRecomReusableView.swift
//  Mall
//
//  Created by iOS on 2022/5/17.
//

import UIKit

class MMNineRecomReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        
        self.addSubview(self.recomImagV)
        self.recomImagV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(self.clockImageV)
        self.clockImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(STtrans(12))
            make.centerY.equalTo(self.snp.centerY).multipliedBy(1.5)
            make.width.height.equalTo(STtrans(14))
        }
        self.addSubview(self.clockTitleLabel)
        self.clockTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.clockImageV.snp.right).offset(2)
            make.centerY.equalTo(self.clockImageV.snp.centerY)
        }
        
        self.addSubview(self.hotTitleLabel)
        self.hotTitleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-STtrans(12))
            make.centerY.equalTo(self.snp.centerY).multipliedBy(1.5)
        }
        
        self.addSubview(self.hotImageV)
        self.hotImageV.snp.makeConstraints { (make) in
            make.right.equalTo(self.hotTitleLabel.snp.left).offset(-2)
            make.centerY.equalTo(self.hotTitleLabel.snp.centerY)
            make.width.height.equalTo(STtrans(14))
        }
    }
    
    func handleHeadVie(indexPath: IndexPath, robbingNum: Int = 0) {
        if indexPath.section == 0 {
            self.hotTitleLabel.isHidden = false
            self.hotImageV.isHidden = false
            self.clockImageV.isHidden = false
            self.clockTitleLabel.isHidden = false
            self.recomImagV.isHidden = true
            self.hotTitleLabel.text = "\(robbingNum.formatUsingAbbrevation())人正在抢 "
        }
        else
        {
            self.hotTitleLabel.isHidden = true
            self.hotImageV.isHidden = true
            self.clockImageV.isHidden = true
            self.clockTitleLabel.isHidden = true
            self.recomImagV.isHidden = false
        }
    }
    
    
   private lazy var recomImagV: UIImageView = {
        let _v = UIImageView()
        _v.setImageWith(URL(string: "https://sr.ffquan.cn/dtk_www/20210226/c0sbpgn6vrkfhsos6qvg0.png"), placeholder: kGlobalDefultImage)
        return _v
    }()
    
    private lazy var clockImageV: UIImageView = {
        let _v = UIImageView(image: UIImage(data: Data(base64Encoded: clockString)!))
        return _v
    }()
    private lazy var clockTitleLabel: UILabel = {
        let _lab = UILabel()
        _lab.textAlignment = .left
        _lab.textColor = UIColor.white
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 16)
        _lab.text = "近1小时疯抢"
        return _lab
    }()
    
    private lazy var hotImageV: UIImageView = {
        let _v = UIImageView(image: UIImage(data: Data(base64Encoded: hotString)!))
        return _v
    }()
    private lazy var hotTitleLabel: UILabel = {
        let _lab = UILabel()
        _lab.textAlignment = .right
        _lab.textColor = UIColor.white
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 14)
        _lab.text = "2.9万人正在抢 "
        return _lab
    }()
    
    
    private let clockString: String = "iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAAAXNSR0IArs4c6QAAAZhJREFUOE9dkk+Lj2EUhq9rhpmFBTvZmNKgRrKYsFGGEhk1DQuJJnyIWfgGvgAWsrBhNsNCSjIpmvxpNhSlycKfhexImjC3zq/nrd/Mu3nfnvNc59zvfW4Bkgyoq0mGgEvARWBnlYAPwC3gtvqnu2uSQfVfkr3AfWA78BB4BghMACeAZWBafdeD28R9wGvgCTCjfk9yoGrqqyTbgLtAnY0X3IFvgU/qZJIN6t8kNbXAk32qFoDN6nhJnQFuALvUL0mG1ZUk94D696kkm9RfSUaB98D5Ah8DK+qpmtam1MQCo55u5/VdXjwFfhb4sfSrV9aB9U/TQDXeAsyqi0muAUcLLLfm1dkGrrbVHAculAJgGLiqLiW5Dhwu8EEV1GOdCe3ymlefQc+BbwWeAe4AY+pyn6sDZU6jN6q/k+wB3gBT3ToWW0oOafXKYFt+b83NlDLuJfBDPdKBO4AloIw62yb3aq3RGDAHbG0B+Fztu5yOtOJB4EWTVFIrVftbBM+pX/sjVxcq0PVMApeB3e2sFn5TfZSkVFiu/wea+PGre2PrLgAAAABJRU5ErkJggg=="
   private let hotString: String = "iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAAAXNSR0IArs4c6QAAAgVJREFUOE91kk8opHEYxz/P733H3wxRlKNkl4NcmByG02ySk5KLtriglLUp0pYLx20vbsrcXJRII1Nqik1KKTcHJ4cph0kM0xjv+3u2d4wm7e7v9n1+fZ/v93mer1B6quqIiB9AVQ1xf1/D+XlehodfSjUTfImIBlhKxSJJVT8B31CNotqEMVmsvcSYDRH5rapGRGyR+A5U9SuwCVQEnVldFUZGoLdX8X1BZF0c54dqICr6rvgFSAYeEfEoFBz6+oRCQUmlLC0tYK2LMd9F5FdxrJLVcyCC73s4jksiAdPTkMvB/HygaunpMbS2ZsjluqW2Nh1Y7cfaU4xxuLoCEVhZgYuLQAU6OsDzIBbzWFtzyeenpLo6HhAnsXYLY3yWlhxSKUinIRyGaBQODoI1Q329x8mJS3PzTxFZFC0UJgmFtri99YnFHB4eoK6O4lzJJCwswP4+vL56bG+7DA2ViJlMP42Np+zuOszMvF11fBwmJiASgbOzN/z46BGPu4yOTolIvLycRCLC2JhHe7vL3h60tb01yWZhYMByd2c4Ps7Q1dUtIunyOV5ekgwOKg0NHkdHDp4nuK6Sy1k6O2F21mV5uXyODwG4udlkZ6eCxUUlFCo25fpaOTwU5ubWpbLyrwC8R+4zT0/zVFVFcd2mwCjPz5dYuyHh8MfI/TfkUAPkReSfIf8DjT4OHsPvPaoAAAAASUVORK5CYII="
    
}
