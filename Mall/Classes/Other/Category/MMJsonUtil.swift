//
//  MMJsonUtil.swift
//  Mall
//
//  Created by iOS on 2022/5/25.
//

import UIKit
import HandyJSON

class JsonUtil: NSObject {
    /*
     *  Json转对象
     */
    static func jsonToModel(_ jsonStr:String,_ modelType: HandyJSON.Type) ->HandyJSONModel {
        if jsonStr == "" || jsonStr.count == 0 {
            #if DEBUG
            NSLog("jsonoModel:字符串为空")
            #endif
            return HandyJSONModel()
        }
        return modelType.deserialize(from: jsonStr)  as! HandyJSONModel
    }
    
    /**
     *  Json转数组对象
     */
    static func jsonArrayToModel(_ jsonArrayStr:String, _ modelType:HandyJSON.Type) ->[HandyJSONModel] {
        if jsonArrayStr == "" || jsonArrayStr.count == 0 {
            #if DEBUG
            NSLog("jsonToModelArray:字符串为空")
            #endif
            return []
        }
        var modelArray:[HandyJSONModel] = []
        let data = jsonArrayStr.data(using: String.Encoding.utf8)
        let peoplesArray = try! JSONSerialization.jsonObject(with:data!, options: JSONSerialization.ReadingOptions()) as? [AnyObject]
        for people in peoplesArray! {
            modelArray.append(dictionaryToModel(people as! [String : Any], modelType))
        }
        return modelArray
    }
    
    /**
     *  字典转对象
     */
    static func dictionaryToModel(_ dictionStr:[String:Any],_ modelType:HandyJSON.Type) -> HandyJSONModel {
        if dictionStr.count == 0 {
            #if DEBUG
            NSLog("dictionaryToModel:字符串为空")
            #endif
            return HandyJSONModel()
        }
        return modelType.deserialize(from: dictionStr) as! HandyJSONModel
    }
    
    /**
     *  对象转JSON
     */
    static func modelToJson(_ model:HandyJSONModel?) -> String {
        if model == nil {
            #if DEBUG
            NSLog("modelToJson:model为空")
            #endif
             return ""
        }
        return (model?.toJSONString())!
    }
    
    /**
     *  对象转字典
     */
    static func modelToDictionary(_ model:HandyJSONModel?) -> [String:Any] {
        if model == nil {
            #if DEBUG
            NSLog("modelToJson:model为空")
            #endif
            return [:]
        }
        return (model?.toJSON())!
    }
    
}
