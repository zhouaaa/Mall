//
//  MMPreferentMainListModel.swift
//  Mall
//
//  Created by iOS on 2022/4/14.
//

import UIKit
import YYKit

class MMPreferentMainListModel: HandyJSONModel {
    
    var totalNum: Int?
    
    var pageId: Int?
    
    var goScroll: Bool?
    
    var list: [MMPreferentMainModel]?
}


class MMPreferentMainModel: HandyJSONModel {
    
    ///内容中包含的链接地址解析出的商品、活动、优惠券ID
    var itemIds : String?
  
    ///线报内容
    var  content: String?
  
    ///线报展示内容
    var  contentCopy : String?

    ///线报图片
    var   picUrls : String?
 
    /// 分类：1淘宝好价，2天猫超市，3京东好价
    var   type : Int?
 
    ///平台信息
    var   platform : String?
  
    ///类型：1淘宝商品2天猫商品3猫超商品4店铺5会场6优惠券7京东商品
    var   detailType : Int?
    
    /// 内容中包含的跳转链接地址
    var   urls : String?
 
    /// 是否推荐：1是，2否
    var    isRecommend : Int?
 
    /// 推广数
    var   tgNum : Int?
  
    ///首页推荐：1是，2否
    var   homeRecommend : Int?
  
    /// 首页推荐文案
    var  recommendDesc : String?
 
    /// 创建时间
    var   createTime : String?
 
    /// 修改时间
    var   updateTime : String?
  
    /// 相同步骤车内不同子消息中此字段相同，根据updateTime或createTime判断步骤的先后顺序，如果updateTime较大的排序靠后
    var   msgSteptId : String?
  

    var _platformType : MMPreferentSourceType {
        return MMPreferentSourceType(rawValue: detailType ?? 1) ?? .Taobao
    }
    
    var _platformTypeIcon: String {
        switch _platformType {
        case .Taobao:
            return "https://sr.ffquan.cn/dtk_zhonghe/20220406/c96gf1u3iplp0kst0u3g1.jpg"
        case .Tmall,.TmallCat:
            return "https://sr.ffquan.cn/dtk_zhonghe/20220406/c96gf1u3iplp0kst0u3g2.jpg"
        case .Stores,.Venue, .Coupons:
            return "https://sr.ffquan.cn/dtk_zhonghe/20220406/c96gf1u3iplp0kst0u3g1.jpg"
        case .JINGdong:
            return "https://sr.ffquan.cn/dtk_zhonghe/20220406/c96gf1u3iplp0kst0u3g0.jpg"
        }
    }
    
  }


enum MMPreferentSourceType: Int {
    case Taobao = 1 //1淘宝商品
    case Tmall = 2 //2天猫商品
    case TmallCat = 3 //3猫超商品
    case Stores = 4 //4店铺
    case Venue = 5 //5会场
    case Coupons = 6 //6优惠券
    case JINGdong = 7 //7京东商品
}
