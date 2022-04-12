//
//  MMActivityApi.swift
//  Mall
//
//  Created by iOS on 2022/4/12.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON
import CoreText


let kMMActivityApiProvider: MoyaProvider<MMActivityApi> = MoyaProvider(endpointClosure: createDefaultEndpointClosure())

enum MMActivityApi {
    /// GetActivityCatalogue 热门活动
     case GetActivityCatalogue
    
    /**
     * Class GetActivityGoodsList 活动商品
     * Integer pageId required 分页id，默认为1
     * Integer pageSize 每页条数，默认为100，大于100按100处理
     * Integer activityId required 通过热门活动API获取的活动id
     * Integer cid 大淘客一级分类ID：1 -女装，2 -母婴，3 -美妆，4 -居家日用，5 -鞋品，6 -美食，7 -文娱车品，8 -数码家电，9 -男装，10 -内衣，11 -箱包，12 -配饰，13 -户外运动，14 -家装家纺
     * Integer subcid 大淘客二级分类ID：可通过超级分类接口获取二级分类id，当同时传入一级分类id和二级分类id时，以一级分类id为准
     * Integer freeshipRemoteDistrict 偏远地区包邮：1.是，0.否
     */
    case GetActivityGoodsList(activityId:String = "",
                              cid: String = "",
                              subcid: String = "",
                              freeshipRemoteDistrict: Int = 1,
                              pageId:Int = 1,
                              pageSize: Int = 100)
    /**
     * Class GetActivityLink 官方活动会场转链
     * String promotionSceneId required  联盟官方活动ID，从联盟官方活动页获取（或从大淘客官方活动推广接口获取（饿了么微信推广活动ID：20150318020002192，饿了么外卖活动ID：20150318019998877，饿了么商超活动ID：1585018034441）
     * String pid 推广pid，默认为在”我的应用“添加的pid
     * String relationId 渠道id将会和传入的pid进行验证，验证通过将正常转链，请确认填入的渠道id是正确的
     * String unionId 自定义输入串，英文和数字组成，长度不能大于12个字符，区分不同的推广渠道
     */
    case GetActivityLink(promotionSceneId:String,
                         pid:String,
                         relationId:String,
                         unionId:String)
    
    
    /**
     * Class GetAlbumGoodsList 单个专辑商品列表
     * Integer albumId required 专辑id
     */
    case GetAlbumGoodsList(albumId: String)
    /**
     * Class GetAlbumList 专辑列表
     * Integer pageId 默认为1，支持scroll查询
     * Integer pageSize 每页记录条数：10，20，50，100
     * Integer albumType required 专辑类型：0-全部，1-官方精选，2-创作者
     * Integer sort 排序方式，0-默认排序；1-按推广量降序排列
     */
    case GetAlbumList(albumType: String, sort: Int, pageId: Int = 1, pageSize: Int = 20)
    
    
    
    /**
     * Class GetBrandColumnList 品牌栏目
     * Integer pageId required 分页id，默认为1
     * Integer pageSize required 每页记录条数（每页记录最大支持50，如果参数大于50时取50作为每页记录条数）
     * Integer cid required 大淘客分类id
     */
    case GetBrandColumnList(cid: String, pageId: Int = 1, pageSize: Int = 20)
    /**
     * Class GetBrandList 单个品牌详情
     * Integer pageId required 分页id，默认为1
     * Integer pageSize required 每页条数，默认为100，大于100按100处理
     * Integer brandId required 品牌id
     */
    case GetBrandList(brandId: String, pageId: Int = 1, pageSize: Int = 100)
    /**
     * Class GetBrandStore 品牌库
     * Integer pageId required 分页id
     * Integer pageSize 每页条数，默认为20，最大值100
     */
    case GetBrandStore(pageId: Int = 1, pageSize: Int = 20)
    
    /**
     * Class GetCarouseList 轮播图
     */
    case GetCarouseList
    
}

extension MMActivityApi: BaseApi {
    
    var path: String {
        switch self {
        case .GetActivityCatalogue:
            return "api/goods/activity/catalogue"
        case .GetActivityGoodsList:
            return "api/goods/activity/goods-list"
        case .GetActivityLink:
            return "api/tb-service/activity-link"
        
          
        case .GetAlbumGoodsList:
            return "api/album/goods-list"
        case .GetAlbumList:
            return "api/album/album-list"
            
            
        case .GetBrandColumnList:
            return "api/delanys/brand/get-column-list"
        case .GetBrandList:
            return "api/delanys/brand/get-goods-list"
        case .GetBrandStore:
            return "api/tb-service/get-brand-list"
            
            
        case .GetCarouseList:
            return "api/goods/topic/carouse-list"
            
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
        case .GetActivityCatalogue:
            let parametDict = BaseApiConfig.defaultParameters
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
        case .GetActivityGoodsList(let activityId, let cid , let subcid , let freeshipRemoteDistrict , let pageId, let pageSize):
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["activityId"] = activityId
            parametDict["cid"] = cid
            parametDict["subcid"] = subcid
            parametDict["freeshipRemoteDistrict"] = "\(freeshipRemoteDistrict)"
            parametDict["pageId"] = "\(pageId)"
            parametDict["pageSize"] = "\(pageSize)"
            
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
        case .GetActivityLink(let promotionSceneId, let pid, let relationId, let unionId):
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["promotionSceneId"] = promotionSceneId
            parametDict["pid"] = pid
            parametDict["relationId"] = relationId
            parametDict["unionId"] = unionId
            
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
        
            
        case .GetAlbumGoodsList(let albumId):
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["albumId"] = albumId
            
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
        case .GetAlbumList(let albumType, let sort, let pageId, let pageSize):
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["albumType"] = albumType
            parametDict["sort"] = "\(sort)"
            parametDict["pageId"] = "\(pageId)"
            parametDict["pageSize"] = "\(pageSize)"
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
            
        case .GetBrandColumnList(let cid , let pageId , let pageSize):
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["cid"] = cid
            parametDict["pageId"] = "\(pageId)"
            parametDict["pageSize"] = "\(pageSize)"
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
        case .GetBrandList(let brandId, let pageId, let pageSize):
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["brandId"] = brandId
            parametDict["pageId"] = "\(pageId)"
            parametDict["pageSize"] = "\(pageSize)"
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
        case .GetBrandStore(let pageId, let pageSize):
            var parametDict = BaseApiConfig.defaultParameters
            parametDict["pageId"] = "\(pageId)"
            parametDict["pageSize"] = "\(pageSize)"
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
            
            
        case .GetCarouseList:
            let parametDict = BaseApiConfig.defaultParameters
            return .requestParameters(parameters: parametDict, encoding: URLEncoding.default)
            
        }
    }
    
    
}
