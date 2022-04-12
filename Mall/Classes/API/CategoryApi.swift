//
//  CategoryApi.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

let kCategoryApiProvider: MoyaProvider<CategoryApi> = MoyaProvider(endpointClosure: createDefaultEndpointClosure())

enum CategoryApi {
    case superCategory

    /// type = 0 sort = 0 人气
    /// type = 0 sort = 1 销量
    /// type = 0 sort = 5 升序
    /// type = 0 sort = 6 降序
    /// hasCoupon 优惠券
    case listSuperTaoBaoGoods(keyWords: String, hasCoupon: Bool = false, type: Int = 0, sort: Int = 0 ,currentPage: Int, pageSize: Int = 10)
    /// 淘宝详情
    case getTaoBaoGoodsDetails(goodsId: String)
    /// 淘宝猜你喜欢【推荐】
    case getTaoBaolistSimilerGoods(goodsId: String)
    
    case listSuperJingDongGoods(keyWords: String, currentPage: Int, pageSize: Int = 10)
    
    case getJDGoodsDetails(skuIds: String)
    
    
    case listSupertTktokGoods(keyWords: String, searchType: Int = 0, sortType: Int = 0, currentPage: Int, pageSize: Int = 10)
}

extension CategoryApi : BaseApi {

    var baseURL: URL {
        switch self {
        case .listSuperTaoBaoGoods, .listSupertTktokGoods:
            
            return URL(string: BaseApiConfig.scheme + BaseApiConfig.hostV2)!
            
        default:
            return URL(string: BaseApiConfig.scheme + BaseApiConfig.host)!
        }
    }
    
    var path: String {
        switch self {
        case .superCategory:
            return "api/category/get-super-category"
            
        case .listSuperTaoBaoGoods:
            return "open-api/goods/list-super-goods"
        case .getTaoBaoGoodsDetails:
            return "api/goods/get-goods-details"
        case .getTaoBaolistSimilerGoods:
            return "api/goods/list-similer-goods-by-open"
    
        case .listSuperJingDongGoods:
            return "api/dels/jd/goods/search"
        case .getJDGoodsDetails:
            return "api/dels/jd/goods/get-details"
            
        case .listSupertTktokGoods:
            return "tiktok/tiktok-materials-products-search"
            
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
        case .superCategory:
            return .requestParameters(parameters: [
            "version" : "v1.1.0",
             "appKey" : "612bcfe884763",
            "sign":"2c6efa428c88445fa9040ebe3d433954"], encoding: URLEncoding.default)
            
        case .listSuperTaoBaoGoods(let keyWords, let hasCoupon, let type, let sort ,let currentPage, let pageSize):
            var parametDict = [String: String]()
            parametDict["appkey"] = "622b674f76e31"
            parametDict["pageSize"] = "\(pageSize)"
            parametDict["pageId"] = "\(currentPage)"
            parametDict["keyWords"] = "\(keyWords)"
            parametDict["type"] = "\(type)"
            parametDict["sort"] = "\(sort)"
            if hasCoupon {
                parametDict["hasCoupon"] = "1"
            }
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
        
        case .getTaoBaoGoodsDetails(let goodsId):
            var parametDict = [String: String]()
            parametDict["appKey"] = "612bcfe884763"
            parametDict["sign"] = "a54d6dcbd8cf12a3920989d36a636c4d"
            parametDict["version"] = "v1.2.3"
            parametDict["goodsId"] = goodsId
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
     
        case .getTaoBaolistSimilerGoods(let goodsId):
            var parametDict = [String: String]()
            parametDict["appKey"] = "612bcfe884763"
            parametDict["sign"] = "aa5b6041f47e11987b8054903f8245b7"
            parametDict["version"] = "v1.2.2"
            parametDict["id"] = goodsId
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
        case .listSuperJingDongGoods(let keyWords, let currentPage, let pageSize):
            return .requestParameters(parameters: [
            "version" : "v1.1.0",
            "appkey" : "612bcfe884763",
            "sign":"49d0e026a624dc777d44b1a508489e2f",
            "type" : "0",
            "pageSize":"\(pageSize)",
            "pageId":"\(currentPage)",
            "keyWords":"\(keyWords)"], encoding: URLEncoding.default)

        case .getJDGoodsDetails(let skuIds):
            var parametDict = [String: String]()
            parametDict["appKey"] = "612bcfe884763"
            parametDict["sign"] = "8460450d8b4e029692ebb857b14571f2"
            parametDict["version"] = "v1.0.0"
            parametDict["skuIds"] = skuIds
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
        case .listSupertTktokGoods(let keyWords,
                                   let searchType,
                                   let sortType,
                                   let currentPage,
                                   let pageSize):
            
            return .requestParameters(parameters: [
            "appkey" : "622b674f76e31",
            "pageSize":"\(pageSize)",
            "page":"\(currentPage)",
            "title":"\(keyWords)",
            "searchType":"\(searchType)",
            "sortType":"\(sortType)"], encoding: URLEncoding.default)
        }
    }

}
