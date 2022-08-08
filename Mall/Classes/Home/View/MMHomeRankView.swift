//
//  MMHomeRankView.swift
//  Mall
//
//  Created by iOS on 2022/6/7.
//

import UIKit

class MMHomeRankView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI() {
        
        self.addSubview(self.titleLeftLabel)
        self.titleLeftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(STtrans(6))
            make.top.equalTo(self.snp.top).offset(STtrans(10))
            make.height.equalTo(STtrans(18))
        }
        
        self.addSubview(self.leftBgImageV)
        self.leftBgImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLeftLabel.snp.right).offset(STtrans(3))
            make.right.equalTo(self.snp.right).offset(-STtrans(3))
            make.centerY.equalTo(self.titleLeftLabel.snp.centerY)
            make.height.equalTo(self.leftBgImageV.snp.width).multipliedBy(14.55/69.68)
        }
        self.leftBgImageV.addSubview(self.msgLeftLabel)
        self.msgLeftLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.leftBgImageV.snp.centerY)
            make.centerX.equalTo(self.leftBgImageV.snp.centerX).offset(STtrans(8))
        }
        self.leftBgImageV.addSubview(self.leftLineImageV)
        self.leftLineImageV.snp.makeConstraints { (make) in
            make.right.equalTo(self.msgLeftLabel.snp.left).offset(-STtrans(2))
            make.centerY.equalTo(self.msgLeftLabel.snp.centerY)
            make.width.equalTo(STtrans(12))
        }
        
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.titleLeftLabel.snp.bottom).offset(STtrans(8))
        }
        
    }
    
    func reloadHomeRankViewList(lists: [MMHomeRankModel]) {
        self.dataLists = lists
        self.collectionView.reloadData()
    }
    
    private lazy var collectionView: UICollectionView = {
        let _layout = UICollectionViewFlowLayout()
        _layout.scrollDirection = .horizontal
        let _v = UICollectionView(frame: .zero, collectionViewLayout: _layout)
        _v.delegate = self
        _v.dataSource = self
        _v.backgroundColor = UIColor.clear
        _v.showsHorizontalScrollIndicator = false
        _v.showsVerticalScrollIndicator = false
        _v.register(MMHomeRankCollectionCell.self, forCellWithReuseIdentifier: MMHomeRankCollectionCell.reuseId)
        return _v
    }()

    private var dataLists = [MMHomeRankModel]()
    
    private lazy var titleLeftLabel: UILabel = {
        let _lab = UILabel()
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 14)
        _lab.textColor = UIColor.hexColor(0x333333)
        _lab.text = "全网热销榜"
        return _lab
    }()
    private lazy var msgLeftLabel: UILabel = {
        let _lab = UILabel()
        _lab.font = UIFont.df_getCustomFontType(with: .Medium, fontSize: 12)
        _lab.textColor = UIColor.hexColor(0xff0000)
        _lab.textAlignment = .center
        _lab.text = "实时好货"
        return _lab
    }()
    private lazy var leftBgImageV: UIImageView = {
        let _v = UIImageView()
        _v.image = UIImage(data: Data(base64Encoded: leftBgString)!)
        return _v
    }()
    private lazy var leftLineImageV: UIImageView = {
        let _v = UIImageView()
        _v.image = UIImage(data: Data(base64Encoded: leftLineString)!)
        return _v
    }()
    
    private let leftBgString: String = "iVBORw0KGgoAAAANSUhEUgAAAIYAAAAcCAYAAACkhMe0AAAAAXNSR0IArs4c6QAAAydJREFUaEPtW0trU0EU/r5b+0BdNkHbBLqp4mPjwo0FoWJR3LvwH4iCIO4EEfwBbgSpiyqIdOHKrWiLG4X+AaH4BJtIG4VWbElqc4+c+4g3aRJuSiideAa6aJiZe853Ps5rZogmQ0Q8AEJSpFjcj/7qaQjPA5gAOQpgBCIHm6213xxFgFyHLy/h8TYzo4tsVENJQdIPyFEqXgZxE5BTEAw4qrKJnQ4BH4A6hE8gLtURQ0T6SFblR/EYfJkG5Kx6jmjfeKH+u41Q6b5ts/Y4AlsA9sHH85qBa57iZ2EKVXkGIAtAyaDEUCYZGfa4VbsmHrkeGLtGipVvF0HvBUQGAVQB9HXtY7aROwgoMWqkKBWOQvAGkEMAQpdio1cRiNODRv3UGfwLJSJClApzACbNU/QqF4II0C4liHJIfgXlQhhKSoUrEJmNcgpdbKO3EEgWDuXIzvUaBuUqXoP+XWbzHyjyZQilgTlAzpi36C02RNpo2CAE84A8BAffYmvr1zZNKxUfY2MV7V0FZad8X5pEH15FiWa4iY1eQSD0FOI9QvbwdW1FtFMsSCkAah+Lsrx0D8Qd8xa9woWaHmFVSSzgj3eOIyMbIqIFRUtyxN4i9BgrS/NR0pmMQz2H0n+oUOT95Qaz+QdKCpJabaYalFJhESJHokaWhZFUsDkzqQpPJjicX4jbEmklV2L8hsiBtAtsnlMIGDGcMtfuCGuhZHdwdu4rbZPPZKLZTDNLPp2zd0cCty1Xk/duGne1crUjnJ2cXN/g8obeoVxeRS63GVyxCHsX2ryoOz+xBpeTtu5Y6GQrogJwA5D3gD+DTP6ptsi3E8Na4h2j7OiCxkO0mCxPkFm9Sp7cVO9Ra4mrknaI5qipdy62hg0lhv71g7jFTO5+stcRX9SxY/edg+zyyshreJ+xtn6c4+OVWBm7qOOyWbslO7EJkRPM5j/G4cSu9nULXJf3aUWMIM+Inw0sF6ZAuwzssp07kL11KEluYs8HOoDU/amagOppa+vks4Ec9uDIfaOn0SDyFjKDzNq1puVq4y72RDENri7PYRnUBpdMYzj3OL4Dmmxy/QW0ErCCkfeAigAAAABJRU5ErkJggg=="
    private let leftLineString: String = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAOCAYAAAAmL5yKAAAAAXNSR0IArs4c6QAAASJJREFUOE+V08suBFEQxvHfGZcFVgQrli6ReBEh8RJsWHgSCzY8hsSLSMRlZ6xIWBkLl2mpntPSaY1MJ93pc6rqX199JydpPAWdRL9gCyc5vJs4q2L1ktQExLpgDBdYyfFrrCfem/mpIKWypvxU3SfwiMlc0MN8olfPj1ipoGA8L97yug0wl3jN8bIuGoeCTRxiBHuJ84IpPCBA8UThbADqPpRqCrpYyIm3WDVQ9NQGaCoOQH8whQ5i1pkMe24AwoOXgg0c4xMHFaDyI6RO/wIIcHh0haWccx+A6B5vGPMXoALHaHE6obz0YFhANVp59MOM0BytFVA3sZIajdr2vwF3WMym3GAt/19i+Z/9boywjSOMYicuTT7rH5eptn+KD+x/Adlpb2CRJ4eqAAAAAElFTkSuQmCC"
    
    
}


extension MMHomeRankView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataLists.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MMHomeRankCollectionCell.reuseId, for: indexPath) as! MMHomeRankCollectionCell
        
        if indexPath.row < self.dataLists.count {
            cell.reladRankCollectCell(cellData: self.dataLists[indexPath.row])
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.width - STtrans(20))*0.5, height: collectionView.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: STtrans(4), bottom: 2, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return STtrans(6)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return STtrans(6)
    }
    
}


class MMHomeRankCollectionCell: UICollectionViewCell {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer(radius: STtrans(8), borderWidth: 0.0, borderColor: UIColor.white)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        self.contentView.addSubview(self.iconImageV)
        self.iconImageV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(self.iconImageV.snp.width)
        }
        
        self.iconImageV.addSubview(self.levelImageV)
        self.levelImageV.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalTo(STtrans(14.5))
            make.height.equalTo(STtrans(15.59))
        }
        
        self.contentView.addSubview(self.bgView)
        self.bgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImageV.snp.left).offset(STtrans(4))
            make.right.equalTo(self.iconImageV.snp.right).offset(-STtrans(4))
            make.centerY.equalTo(self.iconImageV.snp.bottom)
            make.height.equalTo(STtrans(20))
        }
        
    }
    
    
    func reladRankCollectCell(cellData: MMHomeRankModel) {
        
        self.iconImageV.setImageWithURL(cellData.mainPic)
        
    }
    
    
    private lazy var iconImageV: UIImageView = {
        let _v = UIImageView(image: kGlobalDefultImage)
        _v.layer(radius: STtrans(4), borderWidth: 0.0, borderColor: UIColor.clear)
        return _v
    }()
    
    private lazy var levelImageV: UIImageView = {
        let _v = UIImageView(image: UIImage(data: Data(base64Encoded: oneString)!))
        return _v
    }()
    
    private lazy var bgView: UIView = {
        let _v = UIView()
        _v.backgroundColor = UIColor.hexColor(0xff7300)
        return _v
    }()
    
//    linear-gradient(270deg,#ff7300,#ffb717);
//    270deg,#95aebf,#becbd2 99%)
    private lazy var priceLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.hexColor(0xf21724)
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 17)
        _lab.textAlignment = .left
        return _lab
    }()
    
    
    private let oneString: String = "iVBORw0KGgoAAAANSUhEUgAAABwAAAAeCAYAAAA/xX6fAAAAAXNSR0IArs4c6QAAAuFJREFUSEu9V01rFEEQfW8GFSR+oIKKoPiFiAgh5KDgQY1486bB6F2PuYiCCklAD4mIKIIoIiKaaKIIihcT4h+I4lnxKOIhXpKLxJ2S/pjZnp6endlEbAi7SXfXq3r1uqpC2CUCYnCAHBpKZKpnPVZEx4H4BES6IdwMJB3p2aV8MgMcPxWzd6IhH3pOgtEVAJ0ABIA5I+qrv9RW80h+VwDS3NOfZpcqMhIiM+eWYf7bNTRwUVshEojQ7jLFrR2d64vjK2UAEYeQyPSRYQvWMK4gzhn3AywxmN3JuEtzZiPUbE0dPo1ExiCSmPgtjTnGPAuaKofRKofsdcrksTVo/J4G0AVARWciS1OTpahdwLA3lMlDZ7CAZzmwFDEHGuCo4JSbhDLAdwdHIegDkACIaosiVa6rRP9yplCrVK3SNwe+gLIbopXph9E04T+LVOqtXobrQPYsXnfPIWL1ow6Joh06HEDRCgkZrJJ+S8CyHL7qslA1dZ2B+IqposDsUyY6QzXLmk11FNKTv6d+d5evP7NPebG/BeAiklRaamylkbF9/wiwnnOUp3v/M+CTPU5R9L2skmk7xTSl9PEuMQXGT7rKcAToeh4oQLV4KYqO8mhn+dWlBKglWezPlIfbFwdY0u8qRArKg20tAN0RoRaHTRGE2CHmKPe3ismTJxhdSJwcqjMFTbXYz981ZYn8Srm3xbheCMD7gx4EnOW3ntCQ1WxdVj0ySrm7SY1RRe+1AYeX8sZV58WbSYI8S7mzUfXBcLfIReTZ9XMUcsj43IAoMPmE5R1HKbc3lL/DOr63PqMg1U8ExH3s//mccmtd2hoDqnFzFojQpbwwEeiBTK0YEUfYP3tJj6Ryc60tbUsMxwCmEak0RXrkjDCClTuu8vzHBT10y43Vtt1XqDA4EoScpLKnJvXPYHydF369lHHE7DURU4Y72nzRpUzMA/gBYgaI3uLPqve8/H1W0YhBiPp3Qt38C/sjQ6T/3LUKAAAAAElFTkSuQmCC"
    
    
    private let twoString: String = "iVBORw0KGgoAAAANSUhEUgAAABwAAAAeCAYAAAA/xX6fAAAAAXNSR0IArs4c6QAAAvhJREFUSEutV8tqFEEUvacmURcBFy7ED3AvMh+gEgQRQUQGY8As/QNdKMwIujAf4StkjGOMmDEx6uRNJom2Ma4E/QBx4SqCmNh9papf1dXVj0QbhmLmVvW5j3NP3QEFDzOjQYRbgNdZ/3zIE+5pl+gcwFViOsLMfeHesiszEwAKV3kO4eFWq1Wp1Wru9NqniwS6QUTHiIj1PWWB5D4bmAKUkQFgx3F6v+/su03gaz4Qe0QMIiBYd4MX+Bn6K1f/QZ1ZyDROrW7eZVJgbmCr+AlIHwqOZkbh22MQ3VOV0lcrG5dcgcdE5AWugY39Mk79kXYVe7SaADDsgZstxzl4YFvMgek4QUVX8WtQnME9AU51P1522RtljsGifBsMS0YoGahHmHRQZ6ckUPTOya7TZI8GiCDTKUKDyTL9UOxQDKgR3q+gagndHqT0xcqHL+zx0X9pgeLkxzvwfOn9FhHtuql3A5Jg6cTiu0x6ZNWhDFhmDZ8tSMA0pjxgkqQMUCIajXQhBzA+v85mj8VtETe96UARuNmnEdHG59cUeBaojWk2sCKhiACfzq1KMVU0NjrJ+G6z67JnSFGWtLVmu1bS+FEnr5akByZYOYfwpNPNqWF2pWzaau62KRHG3q4owDLamWRgUtaKHAjtClC/kctKW5pk6TZKlsRPOZqvlxVpih6TVGa6it+hARaB/T87tjA6s2xVmnIgeRNBUqhkNgF8xejMkqqheb2kGWbrnvwRRHuHx0wCQBMj04vqTUUss88o2YCGeKtJoqcXgxiZXsiUtvy0lk6nP7YAG/t7tk/h0dR8kCsbrdM3drnaRrukXkmOiIqggcEzJ8fw8OWcFTA5HtraplDaonETwPCVsyeu1+t1gQftWemFxfE8YVYXmG3YlT8GH8j5CEKI4V+H+25erVZ31NB9vz0rx+sMbc/RUgIxMSFa4zT6EWBTuN6dofP94+HfCEXOe5OdPY0YqRGC8RNE3wByqFJp4/efN0MX+n/INDYaDalmCucvv0a8tIkrVx8AAAAASUVORK5CYII="

}
