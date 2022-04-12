//
//  BaseApi.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import Foundation
import Moya
import RxSwift
import SwiftyJSON
import UIKit
import YYKit

struct BaseApiConfig {
    
    static var scheme: String {
        return "https://"
    }

    static var host: String {
        return "openapi.dataoke.com"
    }

    static var hostV2: String {
        return "openapiv2.dataoke.com"
    }
    
    static var hostV3: String {
        return "cmscg.dataoke.com"
    }
    
    
    
    
    static var timeoutInterval: RxTimeInterval = DispatchTimeInterval.seconds(60)
    static var defaultPageSize: Int = 10
    
    static var defaultHeaders: [String: String] {

        return [
            "Platform-Version"   : "iOS:\(kCurrentVersion):\(kGlobalDevice)",
            "version"            : kCurrentVersion,
            "imei"               : kGlobalUDID,
            "device-info"        : kGlobalDevice,
            "Client-Zone-Id"     : NSTimeZone.system.identifier,
            "Build-Version"      : kBuildVersion,
            "Content-Type"       : "application/json",
            "Origin"             : "http://lajic.cn",
            "Referer"            : "http://lajic.cn/",
            "Accept-Language"    : "zh-CN,zh;q=0.9",
            "Accept"             : "application/json"
        ]
    }
    
    /// 默认参数
    static var defaultParameters: [String: String] {
        let appKey = "6254fc0e7d23b"
        let key = "f457890c7a40f38bdf52d05cbbe04861"
        let timer = Double(Date().timeIntervalSince1970) * 1000
        let nonce = randomCustom(min: 100000, max: 999999)
        let signRan = "appKey=\(appKey)&timer=\(timer)&nonce=\(nonce)&key=\(key)"
        let singRanMd5 = signRan.md5()
        
    return [
        "appKey": "\(appKey)",
        "version": "v3.0.0",
        "timer": "\(timer)",
        "nonce": "\(nonce)",
        "signRan": "\(singRanMd5 ?? "")"]
    }
    
}


protocol BaseApi: TargetType {
    
     
}


extension BaseApi {
    
    public var baseURL: URL { return URL(string: BaseApiConfig.scheme + BaseApiConfig.host)! }
    
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    public var headers: [String: String]? {
        return BaseApiConfig.defaultHeaders
    }
}


extension MoyaProvider {
    
    public func yn_requestWithHeaders(_ target: Target) -> Observable<(data: JSON, headers: JSON)> {

        return
            self.rx.request(target)
                .asObservable()
                .timeout(BaseApiConfig.timeoutInterval, scheduler: MainScheduler.asyncInstance)
                .catch{ (error) -> Observable<Moya.Response> in
                    switch error {
                    case is MoyaError: // Moya框架封装的网络错误
                        throw mapMoyaError(error as! MoyaError) ?? error
                    case is RxError: // 可能为超时错误
                        throw mapRxError(error as! RxError) ?? error
                    default: // 不可能触发
                        throw error
                    }
                }
                .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
                .map({ response -> Moya.Response in
                    
                    let headers = JSON(response.response?.allHeaderFields ?? [:])
                    
                    switch response.statusCode {
                    case let x where x >= 200 && x < 300:
                        // 请求成功, 没有网络状态错误, 进入下一步
                        return response
                    default:
                        // http错误(网络请求成功, 报错)
                        // 服务端协商好的错误提示
                        let userInfo = ["_headers": (headers.dictionaryObject ?? [:])]
                        if let ynError = mapYnError(statusCode: response.statusCode, userInfo: userInfo)
                        {
                            throw ynError
                        }
                        // 非协商好的错误提示
                        let json = try? JSON(data: response.data)
                        let rawString = json?.rawString()
                        let utf8String = String(data: response.data, encoding: .utf8)
                        let domain = (rawString ?? utf8String) ?? response.debugDescription
                        throw NSError( domain: domain, code: response.statusCode, userInfo: nil)
                    }
                })
                .map { response -> (data: JSON, headers: JSON) in
                    // response头部, 如果API报错, 也有可能用到
                    let headers = JSON(response.response?.allHeaderFields ?? [:])
                    
                    guard
                        let json = try? JSON(data: response.data)
                        else
                    {
                        return (data: [:], headers: headers)
                    }
                    
                    // 服务端业务代码, 0为API调用成功
                    let code = json["code"].intValue
                    
                    // 没有业务错误, 成功
                    if code == 0 || code == 1 {
                        return  (data: json["data"], headers: headers)
                        debugPrintTarget(target)
                        debugPrint("success: \(target.baseURL.absoluteString + "/" + target.path)")
                    }
                    else {
                        var _json = json
                        _json["_headers"] = headers
                        debugPrint("get domain error:", json.dictionaryObject ?? [:])
                        // 请求成功, 出现业务错误
                        let domain = json["msg"].string ?? kDefaultErrorMessage
                        let userInfo = _json.dictionaryObject
                        let ynError = mapYnError(statusCode: code, userInfo: userInfo)
                        let defaultError = NSError(domain: domain, code: code, userInfo: userInfo)
                        throw ynError ?? defaultError
                    }
                }
                .observe(on: MainScheduler.asyncInstance)
                .do(onError: { err in
                    injectHandleError(err as NSError)
                    debugPrintTarget(target)
                    debugPrint(err)
                })
    }
    
    public func yn_request(_ target: Target) -> Observable<JSON> {
        return yn_requestWithHeaders(target).map {$0.data}
    }
}


private func injectHandleError(_ error: NSError) {
    switch error.code {
    case 401, 2034:
        break
    case 4018:
        break
    default:
        break
    }
}

private func debugPrintTarget<Target: TargetType>(_ target: Target) {
    let url = target.baseURL.absoluteString + "/" + target.path
    debugPrint("task url:", url)
    debugPrint("headers:", target.headers ?? [:])
    debugPrint("task:", target.task)
}

/*
 把moya error映射成用户可读的error
 */
private func mapMoyaError(_ error: MoyaError) -> Error? {
    switch error {
    case .underlying(let _error, _): // 暂时只处理 underlying 类型
        return mapUnderlyingError((_error as NSError).code)
    default:
        return nil
    }
}

private func mapRxError(_ error: RxError) -> Error? {
    switch error {
    case .timeout:
        return NSError(domain: "Request timed out, please try again later", code: 0, userInfo: nil)
    default:
        return nil
    }
}

private func mapUnderlyingError(_ code: Int) -> Error? {
    switch code {
    case -1009:
        return NSError(domain: "当前没有网络连接, 请检查网络.", code: code, userInfo: nil)
    case -1001:
        return NSError(domain: "网络连接超时, 请检查网络.", code: code, userInfo: nil)
    case -1000:
        return NSError(domain: "有问题的路径访问.", code: code, userInfo: nil)
    case -1002:
        return NSError(domain: "不支持的路径类型.", code: code, userInfo: nil)
    case -1003:
        return NSError(domain: "未能发现主机，请检查网路.", code: code, userInfo: nil)
    case -1004:
        return NSError(domain: "未能连接主机，请检查网路.", code: code, userInfo: nil)
    case -1103:
        return NSError(domain: "参数长度超出限制.", code: code, userInfo: nil)
    case -1005:
        return NSError(domain: "失去网络连接，请检查网络.", code: code, userInfo: nil)
    case -1006:
        return NSError(domain: "DNS寻址错误.", code: code, userInfo: nil)
    case -1007:
        return NSError(domain: "重定向过多.", code: code, userInfo: nil)
    case -1008:
        return NSError(domain: "资源捕获出错.", code: code, userInfo: nil)
    case -1010:
        return NSError(domain: "重定向出错.", code: code, userInfo: nil)
    case -1011:
        return NSError(domain: "有问题服务端响应.", code: code, userInfo: nil)
    case -1012:
        return NSError(domain: "用户取消了授权.", code: code, userInfo: nil)
    case -1013:
        return NSError(domain: "需要用户授权.", code: code, userInfo: nil)
    case -1014:
        return NSError(domain: "资源为空.", code: code, userInfo: nil)
    case -1015:
        return NSError(domain: "无法解码源数据.", code: code, userInfo: nil)
    case -1016:
        return NSError(domain: "无法解码内容数据.", code: code, userInfo: nil)
    case -1017:
        return NSError(domain: "无法解析响应.", code: code, userInfo: nil)
    case -1018:
        return NSError(domain: "国际漫游关闭.", code: code, userInfo: nil)
    case -1019:
        return NSError(domain: "调用活跃中.", code: code, userInfo: nil)
    case -1020:
        return NSError(domain: "数据回调被拒绝.", code: code, userInfo: nil)
    case -1021:
        return NSError(domain: "请求体丢失.", code: code, userInfo: nil)
    case -1100:
        return NSError(domain: "文件不存在.", code: code, userInfo: nil)
    case -1101:
        return NSError(domain: "文件目录不存在.", code: code, userInfo: nil)
    case -1102:
        return NSError(domain: "没有权限读取文件.", code: code, userInfo: nil)
    default:
        return nil
    }
}

private func mapYnError(statusCode: Int, userInfo: [String: Any]?) -> Error? {
    switch statusCode {
    case 500:
        return NSError(domain: "服务器异常, 请联系客服或升级APP", code: statusCode, userInfo: userInfo)
    default:
        return nil
    }
}


public func createDefaultEndpointClosure<Target: TargetType>() -> (_ target: Target) -> Endpoint {
    
    return { (target: Target) -> Endpoint in
        let url = target.baseURL.absoluteString + "/" + target.path
        debugPrint("make request:")
        debugPrintTarget(target)
        
        var finalTask = target.task
        
        switch (target.method, target.task) {
            
        case (.post, .requestParameters(let parameters, _)):
            if let data = try? JSON(parameters).rawData() {
                finalTask = .requestData(data)
            }
        default:
            break
        }
        
        let endpoint: Endpoint =
            Endpoint(
                url: url,
                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                method: target.method,
                task: finalTask,
                httpHeaderFields: target.headers
        )
        
        return endpoint
    }
}


private let kUnkownError: NSError = NSError(domain: "发生未知网络错误, 请联系客服或升级APP", code: 0, userInfo: nil)
