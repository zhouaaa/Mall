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
     * Integer topic  线报类型：1-超值买返2-天猫超市3-整点抢购4-最新线报-所有数据(默认)5-最新线报-天猫6-最新线报-京东7-最新线报-拼多多8-最新线报-淘宝
     * Integer pageId 页码，默认为1
     * Integer pageSize 每页记录数，默认20
     * Integer selectTime rush-整点抢购时的时间戳（秒），示例：1617026400
     */
    case HomelistTipOff(topic: String = "", selectTime: String = "", pageId: Int = 1, pageSize: Int = 20)
    
    case HomeRankingList

}

extension HomeApi: BaseApi {
    
    var baseURL: URL {
        switch self {
        case .HomeCmsV2Ads:
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
            
        case .HomelistTipOff(let topic, let selectTime, let pageId, let pageSize):
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["pageId"] = "\(pageId)"
            parametDict["pageSize"] = "\(pageSize)"
            if topic.isNotBlank() {
                parametDict["topic"] = topic
            }
            if selectTime.isNotBlank() {
                parametDict["selectTime"] = selectTime
            }
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
        case .HomeRankingList:
            var parametDict = [String: String]()
            parametDict["version"] = "v1.3.0"
            parametDict["appKey"] = "612bcfe884763"
            parametDict["rankType"] = "1"
            parametDict["pageId"] = "1"
            parametDict["pageSize"] = "2"
            parametDict["sign"] = "b7e9903326a8cf9a4f4692e850b19ee4"
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
        }
    }
    
    
}
