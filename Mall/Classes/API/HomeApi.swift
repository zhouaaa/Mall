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
    case HomelistTipOff
    
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
            
        case .HomelistTipOff:
            var parametDict = [String: String]()
            parametDict["version"] = "v1.2.4"
            parametDict["appKey"] = "612bcfe884763"
            parametDict["topic"] = "8"
            parametDict["pageId"] = "1"
            parametDict["pageSize"] = "8"
            parametDict["sign"] = "123642fbcba032260bed6ff5586ce18a"
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
