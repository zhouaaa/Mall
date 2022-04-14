//
//  MMPreferentMainListModel.swift
//  Mall
//
//  Created by iOS on 2022/4/14.
//

import UIKit

class MMPreferentMainListModel: HandyJSONModel {
    
    var totalNum: Int?
    
    var pageId: Int?
    
    var goScroll: Bool?
    
    var list: [MMPreferentMainModel]?
}


class MMPreferentMainModel: HandyJSONModel {
    
    var isLuxury: Int?
    
    var imageList: [String]?
    
    var urlList: [String]?
    
    
    var tag: String?
    var updateTime: String?
    /// 平台
    var platformType: String?
    var stepId: String?
    var type: String?
    var source: String?
    var originContent: String?
    var createTime: String?
    var remark: String?
    
    var idList: [String]?
    var title: String?
    var msgId: String?
    
  }
