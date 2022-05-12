//
//  NineApi.swift
//  Mall
//
//  Created by iOS on 2022/4/21.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON


let kNineApiProvider: MoyaProvider<NineApi> = MoyaProvider(endpointClosure: createDefaultEndpointClosure())
//
enum NineApi {
    case NinePageCate
    case NinePageGoodsTop
    case NinePageGoods(cid: String = "2",aid: String = "", pageNo: Int = 1, pageSize: Int = 10)
}

extension NineApi: BaseApi {
    
    var baseURL: URL {
        switch self {
        case .NinePageCate:
            return URL(string: BaseApiConfig.scheme + BaseApiConfig.hostV4)!
        case .NinePageGoodsTop:
            return URL(string: BaseApiConfig.scheme + BaseApiConfig.hostV4)!
        case .NinePageGoods:
            return URL(string: BaseApiConfig.scheme + BaseApiConfig.hostV4)!

        }
    }
    
    var path: String {
        switch self {
        case .NinePageCate:
            return "dtk_go_app_api/v1/page-goods-nine-cate"
        case .NinePageGoodsTop:
            return "dtk_go_app_api/v1/page-goods-nine-top"
        case .NinePageGoods:
            return "dtk_go_app_api/v1/page-goods-nine"
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
        case .NinePageCate:
            let parametDict = BaseApiConfig.defaultParameters
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
        case .NinePageGoodsTop:
            let parametDict = BaseApiConfig.defaultParameters
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
        case .NinePageGoods( let cid , let aid ,let pageNo, let pageSize):
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["cid"] = cid
            if aid.isNotBlank() {
                parametDict["aid"] = aid
            }
            parametDict["pageNo"] = "\(pageNo)"
            parametDict["pageSize"] = "\(pageSize)"
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
       }
    }
    
    
}

