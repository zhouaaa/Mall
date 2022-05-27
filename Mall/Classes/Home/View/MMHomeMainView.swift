//
//  MMHomeMainView.swift
//  Mall
//
//  Created by iOS on 2022/4/11.
//

import UIKit
import YYKit


protocol MMHomeMainViewDelegate {
    func homeMainViewCollectionView(_ collectionView: MMHomeMenusView, didSelectItemAt indexPath: IndexPath)
}


class MMHomeMainView: UIView {

    public var delegate: MMHomeMainViewDelegate!
    
    private var menuHeight: CGFloat {
        get {
            let cellHeight = (kScreenWidth - STtrans(24)) * (62.4/184.6)
            return CGFloat(cellHeight + STtrans(28))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.hexColor(0xf6f6f6)
        
        self.setUI()
        self.bindUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setUI() {
        
        self.addSubview(menuView)
        self.menuView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(menuHeight)
        }
        
        self.addSubview(self.marqueeView)
        self.marqueeView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(STtrans(12))
            make.right.equalTo(self.snp.right).offset(-STtrans(12))
            make.top.equalTo(self.menuView.snp.bottom).offset(STtrans(12))
            make.height.equalTo(STtrans(50))
        }
        
        
        self.addSubview(self.leftView)
        self.leftView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(STtrans(12))
            make.right.equalTo(self.snp.centerX).offset(-STtrans(3))
            make.top.equalTo(self.marqueeView.snp.bottom).offset(STtrans(6))
            make.bottom.equalTo(self.snp.bottom).offset(-STtrans(6))
        }
        
        
        self.addSubview(self.rightView)
        self.rightView.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-STtrans(12))
            make.left.equalTo(self.snp.centerX).offset(STtrans(3))
            make.top.bottom.equalTo(self.leftView)
        }
        
        self.leftView.addSubview(self.titleLeftLabel)
        self.titleLeftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftView.snp.left).offset(STtrans(6))
            make.top.equalTo(self.leftView.snp.top).offset(STtrans(10))
            make.width.equalTo("全网热销榜".width(for: UIFont.boldSystemFont(ofSize: 15)))
            make.height.equalTo(STtrans(18))
        }
        
        self.leftView.addSubview(self.leftBgImageV)
        self.leftBgImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLeftLabel.snp.right).offset(STtrans(3))
            make.right.equalTo(self.leftView.snp.right).offset(-STtrans(3))
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
        
        
        self.rightView.addSubview(self.titleRightLabel)
        self.titleRightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.rightView.snp.left).offset(STtrans(6))
            make.top.equalTo(self.rightView.snp.top).offset(STtrans(10))
            make.width.equalTo("限时秒杀".width(for: UIFont.boldSystemFont(ofSize: 15)))
            make.height.equalTo(STtrans(18))
        }
        
        self.rightView.addSubview(self.rightBgImageV)
        self.rightBgImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleRightLabel.snp.right).offset(STtrans(3))
            make.right.equalTo(self.rightView.snp.right).offset(-STtrans(3))
            make.centerY.equalTo(self.titleRightLabel.snp.centerY)
            make.height.equalTo(STtrans(14.55))
        }
         
        
        
    }
    
    private func bindUI() {
        
    }
    
    
    func reloadMenuData(listData: [MMHomeIconBannerModel]) {
        
        self.menuView.reloadMenuColllectionView(lists: listData)
        
    }
    
    func reloadMarqueeBannerData(listData: [MMPreferentMainModel]) {
        self.marqueeView.reloaCellItemMarqueData(itemList: listData)
    }
    
    private lazy var menuView: MMHomeMenusView = {
        let _v = MMHomeMenusView()
        _v.delegate = self
        return _v
    }()
           
    private lazy var marqueeView: MMHomeMarqueeView = {
        let _v = MMHomeMarqueeView()
        return _v
    }()
    
    private lazy var leftView: UIView = {
        let _v = UIView()
        _v.backgroundColor = UIColor.white
        _v.layer(radius: STtrans(6), borderWidth: 0.00, borderColor: UIColor.white)
        return _v
    }()
    
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
    
    
    private lazy var rightView: UIView = {
        let _v = UIView()
        _v.backgroundColor = UIColor.white
        _v.layer(radius: STtrans(6), borderWidth: 0.00, borderColor: UIColor.white)
        return _v
    }()
    private lazy var titleRightLabel: UILabel = {
        let _lab = UILabel()
        _lab.font = UIFont.df_getCustomFontType(with: .Semibold, fontSize: 14)
        _lab.textColor = UIColor.hexColor(0x333333)
        _lab.text = "限时秒杀"
        return _lab
    }()
    
    
    private lazy var rightBgImageV: UIImageView = {
        let _v = UIImageView()
        _v.image = UIImage(data: Data(base64Encoded: rightBgString)!)
        return _v
    }()
    
    private let leftBgString: String = "iVBORw0KGgoAAAANSUhEUgAAAIYAAAAcCAYAAACkhMe0AAAAAXNSR0IArs4c6QAAAydJREFUaEPtW0trU0EU/r5b+0BdNkHbBLqp4mPjwo0FoWJR3LvwH4iCIO4EEfwBbgSpiyqIdOHKrWiLG4X+AaH4BJtIG4VWbElqc4+c+4g3aRJuSiideAa6aJiZe853Ps5rZogmQ0Q8AEJSpFjcj/7qaQjPA5gAOQpgBCIHm6213xxFgFyHLy/h8TYzo4tsVENJQdIPyFEqXgZxE5BTEAw4qrKJnQ4BH4A6hE8gLtURQ0T6SFblR/EYfJkG5Kx6jmjfeKH+u41Q6b5ts/Y4AlsA9sHH85qBa57iZ2EKVXkGIAtAyaDEUCYZGfa4VbsmHrkeGLtGipVvF0HvBUQGAVQB9HXtY7aROwgoMWqkKBWOQvAGkEMAQpdio1cRiNODRv3UGfwLJSJClApzACbNU/QqF4II0C4liHJIfgXlQhhKSoUrEJmNcgpdbKO3EEgWDuXIzvUaBuUqXoP+XWbzHyjyZQilgTlAzpi36C02RNpo2CAE84A8BAffYmvr1zZNKxUfY2MV7V0FZad8X5pEH15FiWa4iY1eQSD0FOI9QvbwdW1FtFMsSCkAah+Lsrx0D8Qd8xa9woWaHmFVSSzgj3eOIyMbIqIFRUtyxN4i9BgrS/NR0pmMQz2H0n+oUOT95Qaz+QdKCpJabaYalFJhESJHokaWhZFUsDkzqQpPJjicX4jbEmklV2L8hsiBtAtsnlMIGDGcMtfuCGuhZHdwdu4rbZPPZKLZTDNLPp2zd0cCty1Xk/duGne1crUjnJ2cXN/g8obeoVxeRS63GVyxCHsX2ryoOz+xBpeTtu5Y6GQrogJwA5D3gD+DTP6ptsi3E8Na4h2j7OiCxkO0mCxPkFm9Sp7cVO9Ra4mrknaI5qipdy62hg0lhv71g7jFTO5+stcRX9SxY/edg+zyyshreJ+xtn6c4+OVWBm7qOOyWbslO7EJkRPM5j/G4cSu9nULXJf3aUWMIM+Inw0sF6ZAuwzssp07kL11KEluYs8HOoDU/amagOppa+vks4Ec9uDIfaOn0SDyFjKDzNq1puVq4y72RDENri7PYRnUBpdMYzj3OL4Dmmxy/QW0ErCCkfeAigAAAABJRU5ErkJggg=="
    private let leftLineString: String = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAOCAYAAAAmL5yKAAAAAXNSR0IArs4c6QAAASJJREFUOE+V08suBFEQxvHfGZcFVgQrli6ReBEh8RJsWHgSCzY8hsSLSMRlZ6xIWBkLl2mpntPSaY1MJ93pc6rqX199JydpPAWdRL9gCyc5vJs4q2L1ktQExLpgDBdYyfFrrCfem/mpIKWypvxU3SfwiMlc0MN8olfPj1ipoGA8L97yug0wl3jN8bIuGoeCTRxiBHuJ84IpPCBA8UThbADqPpRqCrpYyIm3WDVQ9NQGaCoOQH8whQ5i1pkMe24AwoOXgg0c4xMHFaDyI6RO/wIIcHh0haWccx+A6B5vGPMXoALHaHE6obz0YFhANVp59MOM0BytFVA3sZIajdr2vwF3WMym3GAt/19i+Z/9boywjSOMYicuTT7rH5eptn+KD+x/Adlpb2CRJ4eqAAAAAElFTkSuQmCC"
    
    private let rightBgString: String = "iVBORw0KGgoAAAANSUhEUgAAAKoAAAAcCAYAAADx5STqAAAAAXNSR0IArs4c6QAABYhJREFUeF7tnEtsFVUYx39n5j7m3tsCbWkpLYVizaUUKAIWAgoWLUoCiY8EjejK+CJGjVa78A0mxsREE+PCjTujJsTEJQkPdaEbFy4N7jXGleFRpPfeOeabc+b2XqiJkpmkZc4kJE2BkzPf95v/95jvjGKBS7+Nx3G0Aq3focxlJgiZAu7AZ5CQAaBjof970/4uBLr74JlPoLwJKAD6pr3d1G5McQm830H/htY/4KkzBJWflBqY1VqQQymlxNptl/xF2yWQquOEEayzHAFeQrPNeia1/S/qhT1gFti9Eyb3Q+fD4K8A6mLXRb31JbC5OZT6GdRHlEZOCqRaa+9aWNusrI/gq5M09AwbgU8J2dciG0K5uEyu7HhH7lTuPK/goSkYHIfOx8BfBjQyZYoEoY9DUTtTSn2Pr4+pYvUXrbWvlBIDtwPXVNJpDqD4HOizLpJFBdDswNnqEbnrq8CeMZjYDPRC35PgdTpQkyFX+BJgxdLC2Z/4PK6C6ulWZY3ga0L6KgfRfAMUrRf8ZPayRFcR60h07y3B/feBryE/AH1Pg98J2ilqwp4Vg/ooruJ5D6jg1lMxrKoJ6QwbCPkO6LfuySW8iaW73MFdsHYNXJ2FYAhWPQu55aBdjpqCU8WoOVB/4DcmVTB6PoI1UlSNYoYzaO52StqSFEnI39wPeyegEYKeg8JaWP2cAzUFQluWtMrqnaM0MqWUitoB6GkeRfGFzRXigindrSzm1cUqYqqKB4f2QiUwnShdg+IQDLwAuRVOUdP1oSm0FEdVufqlhP6AK5wlZI9T0xY1rQH7qlAdhrkaeL5R1OI6GHyxXVFV1P5L123ZW92qqvqRUu4epWfYT8jpKIk1upFti8dV/nAFJm8HbQtSZUENhmHda5DralFUDeHf2UMp3TuOWWzghQeUfoUTwJtOTa3VxTx5YGocujuhHho1ledXiqd8D/RIB6Bsn+sQ/C7oGM/8M54Ct0ZV8d5VeppzKPa7/NRyJgXU9lUwvh7mGvJCz/yJ285K1PNKVIHi5aF+AXofhMFjJofNeEBKGFabp6pvJfSfJ6Sa+bAf90x7fJjcAn5rTSmwCoP2vYekAfJzWINCL6x/Cwp9Jod1oCbJqgn/yvtVQv8lqW+TXH3JriVm2bsO+rugXjcwRmJqoW0WTQo8DxpXYOh56D0E9UsW5CV794t344rLDlRxT1xAVcuwfb3JS+NwH8PZDP/y73PQmIUVu2HkDVtwLV4/L/mdRaBmPfTHPdOygjvXQlA04EVqakO+iftWXeVnyU8D2PA+VEaNskZpgbsStkBL6HfFlBmJ2NEFIz1Qi9VUQT0e8hFI4/DvQ/0iDD0FQ09A/bKDNGE6W5ZrKaZce8rYZZUPRemV2lwg78FwN5Tytrtsh3ukX9oxBmMfGlVtDv6k560Mr2zbU+qEa/jHFMgoRJyvinlKMtq3EjqDFhZFVRuw8QPo3ucKqHSfoGsa/u4V6jygseHFRDLoONENHUUItS2g/oKBo1B93eSlzTnydD2W0dXbX6GKEdxQyjUoNEFdDpW8UVRR0kI/bPsMgn7TQ3U90zSfofahlAhUsfg0Z+0bKpsXpLmHRb52DOqOClQKRMccpR01+h4MPQK1CyBNf3elZYHrx/zc4PQCto5B3RZARwC1i7DyXtj6sX2B52Z30iJ0fmh/ocHp+OSpO4pi7B+DujUPZemnFmDnV7BsC9RnXTsqPUr//ShKs36IYXWH++ZBva0AhTm45WXYMG2U1TX2k8b0vx/ua8Lqjkub+khaVV1lGKvD8mHY9TXkSu4wX3KI3vhx6euUNasfoIjf+6/phzFg03FYfdiM87kCKjlU51f6/x+gaIU1s5/0ib+KMroFDh+DnrvM3Km7krHADX7S5x9NQ+SquvQhJAAAAABJRU5ErkJggg=="
    
}


                                 
                            
extension MMHomeMainView: MMHomeMenusViewDelegate {

    func collectionView(_ collectionView: MMHomeMenusView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.homeMainViewCollectionView(collectionView, didSelectItemAt: indexPath)
    }
}
