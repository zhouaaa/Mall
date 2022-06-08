//
//  MMHomeSpikeView.swift
//  Mall
//
//  Created by iOS on 2022/6/7.
//

import UIKit

class MMHomeSpikeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setUpUI() {
        self.addSubview(self.titleRightLabel)
        self.titleRightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(STtrans(6))
            make.top.equalTo(self.snp.top).offset(STtrans(10))
            make.width.equalTo("限时秒杀".width(for: UIFont.boldSystemFont(ofSize: 15)))
            make.height.equalTo(STtrans(18))
        }
        
        self.addSubview(self.rightBgImageV)
        self.rightBgImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleRightLabel.snp.right).offset(STtrans(3))
            make.right.equalTo(self.snp.right).offset(-STtrans(3))
            make.centerY.equalTo(self.titleRightLabel.snp.centerY)
            make.height.equalTo(STtrans(14.55))
        }
    }
    
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
    
    private let rightBgString: String = "iVBORw0KGgoAAAANSUhEUgAAAKoAAAAcCAYAAADx5STqAAAAAXNSR0IArs4c6QAABYhJREFUeF7tnEtsFVUYx39n5j7m3tsCbWkpLYVizaUUKAIWAgoWLUoCiY8EjejK+CJGjVa78A0mxsREE+PCjTujJsTEJQkPdaEbFy4N7jXGleFRpPfeOeabc+b2XqiJkpmkZc4kJE2BkzPf95v/95jvjGKBS7+Nx3G0Aq3focxlJgiZAu7AZ5CQAaBjof970/4uBLr74JlPoLwJKAD6pr3d1G5McQm830H/htY/4KkzBJWflBqY1VqQQymlxNptl/xF2yWQquOEEayzHAFeQrPNeia1/S/qhT1gFti9Eyb3Q+fD4K8A6mLXRb31JbC5OZT6GdRHlEZOCqRaa+9aWNusrI/gq5M09AwbgU8J2dciG0K5uEyu7HhH7lTuPK/goSkYHIfOx8BfBjQyZYoEoY9DUTtTSn2Pr4+pYvUXrbWvlBIDtwPXVNJpDqD4HOizLpJFBdDswNnqEbnrq8CeMZjYDPRC35PgdTpQkyFX+BJgxdLC2Z/4PK6C6ulWZY3ga0L6KgfRfAMUrRf8ZPayRFcR60h07y3B/feBryE/AH1Pg98J2ilqwp4Vg/ooruJ5D6jg1lMxrKoJ6QwbCPkO6LfuySW8iaW73MFdsHYNXJ2FYAhWPQu55aBdjpqCU8WoOVB/4DcmVTB6PoI1UlSNYoYzaO52StqSFEnI39wPeyegEYKeg8JaWP2cAzUFQluWtMrqnaM0MqWUitoB6GkeRfGFzRXigindrSzm1cUqYqqKB4f2QiUwnShdg+IQDLwAuRVOUdP1oSm0FEdVufqlhP6AK5wlZI9T0xY1rQH7qlAdhrkaeL5R1OI6GHyxXVFV1P5L123ZW92qqvqRUu4epWfYT8jpKIk1upFti8dV/nAFJm8HbQtSZUENhmHda5DralFUDeHf2UMp3TuOWWzghQeUfoUTwJtOTa3VxTx5YGocujuhHho1ledXiqd8D/RIB6Bsn+sQ/C7oGM/8M54Ct0ZV8d5VeppzKPa7/NRyJgXU9lUwvh7mGvJCz/yJ285K1PNKVIHi5aF+AXofhMFjJofNeEBKGFabp6pvJfSfJ6Sa+bAf90x7fJjcAn5rTSmwCoP2vYekAfJzWINCL6x/Cwp9Jod1oCbJqgn/yvtVQv8lqW+TXH3JriVm2bsO+rugXjcwRmJqoW0WTQo8DxpXYOh56D0E9UsW5CV794t344rLDlRxT1xAVcuwfb3JS+NwH8PZDP/y73PQmIUVu2HkDVtwLV4/L/mdRaBmPfTHPdOygjvXQlA04EVqakO+iftWXeVnyU8D2PA+VEaNskZpgbsStkBL6HfFlBmJ2NEFIz1Qi9VUQT0e8hFI4/DvQ/0iDD0FQ09A/bKDNGE6W5ZrKaZce8rYZZUPRemV2lwg78FwN5Tytrtsh3ukX9oxBmMfGlVtDv6k560Mr2zbU+qEa/jHFMgoRJyvinlKMtq3EjqDFhZFVRuw8QPo3ucKqHSfoGsa/u4V6jygseHFRDLoONENHUUItS2g/oKBo1B93eSlzTnydD2W0dXbX6GKEdxQyjUoNEFdDpW8UVRR0kI/bPsMgn7TQ3U90zSfofahlAhUsfg0Z+0bKpsXpLmHRb52DOqOClQKRMccpR01+h4MPQK1CyBNf3elZYHrx/zc4PQCto5B3RZARwC1i7DyXtj6sX2B52Z30iJ0fmh/ocHp+OSpO4pi7B+DujUPZemnFmDnV7BsC9RnXTsqPUr//ShKs36IYXWH++ZBva0AhTm45WXYMG2U1TX2k8b0vx/ua8Lqjkub+khaVV1lGKvD8mHY9TXkSu4wX3KI3vhx6euUNasfoIjf+6/phzFg03FYfdiM87kCKjlU51f6/x+gaIU1s5/0ib+KMroFDh+DnrvM3Km7krHADX7S5x9NQ+SquvQhJAAAAABJRU5ErkJggg=="
    
}
