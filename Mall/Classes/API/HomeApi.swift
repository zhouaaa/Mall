//
//  HomeApi.swift
//  Mall
//
//  Created by iOS on 2022/4/8.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON


let kHomeApiProvider: MoyaProvider<HomeApi> = MoyaProvider(endpointClosure: createDefaultEndpointClosure())

enum HomeApi {
    case HomeCmsV2Ads(siteId: String = "369616", temp_id: String = "2", page: Int = 1)
    /**
     * Class GetTipList 线报
     * Integer topic  线报类型：1淘宝商品 2天猫商品 3猫超商品 4店铺 5会场 6优惠券 7京东商品
     * Integer type 1淘宝好价，2天猫超市，3京东好价
     * Integer pageId 页码，默认为1
     * Integer pageSize 每页记录数，默认20
     * Integer selectTime rush-整点抢购时的时间戳（秒），示例：1617026400
     */
    case HomelistTipOff(topic: String = "", type: String = "" ,selectTime: String = "", pageId: Int = 1, pageSize: Int = 20)
    
    case HomeRankingList
    
    case HomeGoodLists(cids: Int = -1, pageId: Int = 1, pageSize: Int = 20)
    
    /// 大额优惠券
    case HomeCouponColumnConf

    case HomeCouponPageConfig(pageUrl: String, pageId: Int = 1, pageSize: Int = 20)
    
    
}

extension HomeApi: BaseApi {
    
    var baseURL: URL {
        switch self {
        case .HomeCmsV2Ads, .HomeCouponColumnConf:
            return URL(string: BaseApiConfig.scheme + BaseApiConfig.hostV3)!
        
        default:
            return URL(string: BaseApiConfig.scheme + BaseApiConfig.host)!
        }
    }
    
    var path: String {
        switch self {
        case .HomeCmsV2Ads:
            return "cms-v2/ads"
        case .HomelistTipOff:
            return "api/dels/spider/list-tip-off"
        case .HomeRankingList:
            return "api/goods/get-ranking-list"
        case .HomeGoodLists:
            return "api/goods/get-goods-list"
        
        case .HomeCouponColumnConf:
            return "cms-v2/column-conf"
        case .HomeCouponPageConfig(let pageUrl, _, _):
            return "\(pageUrl)"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .HomeCmsV2Ads(let siteId, let temp_id, let page):
            var parametDict = [String: String]()
            parametDict["siteId"] = siteId
            parametDict["temp_id"] = temp_id
            parametDict["page"] = "\(page)"
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
        case .HomelistTipOff(let topic, let type, let selectTime, let pageId, let pageSize):
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["pageId"] = "\(pageId)"
            parametDict["pageSize"] = "\(pageSize)"
            if topic.isNotBlank() {
                parametDict["topic"] = topic
            }
            
            if type.isNotBlank() {
                parametDict["type"] = type
            }
            
            if selectTime.isNotBlank() {
                parametDict["selectTime"] = selectTime
            }
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
        case .HomeRankingList:
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["rankType"] = "1"
            parametDict["pageId"] = "1"
            parametDict["pageSize"] = "2"
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
        case .HomeGoodLists(let cids, let pageId , let pageSize):
            var parametDict = BaseApiConfig.defaultParameters
            if cids >= 0 {
                parametDict["cids"] = "\(cids)"
            }
            parametDict["pageId"] = "\(pageId)"
            parametDict["pageSize"] = "\(pageSize)"
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
            
        case .HomeCouponColumnConf:
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["id"] = "411"
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
        case .HomeCouponPageConfig(_ , let pageId , let pageSize):
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["pageId"] = "\(pageId)"
            parametDict["pageSize"] = "\(pageSize)"
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
        }
    }
    
    
}
