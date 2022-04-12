//
//  MMCategoryListModel.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import UIKit
import SwiftyJSON

class MMCategoryListModel: HandyJSONModel {
    
    var cid: String? /// 一级分类ID
    
    var cname: String?  /// 一级分类名称
    
    var cpic: String?   /// 一级分类图标
    
    var subcategories: [MMCategorySubcategoriesModel]?
    
}


class MMCategorySubcategoriesModel: HandyJSONModel {
    
    var subcid: String? /// 二级分类Id，根据实际返回id为准
    
    var scname: String?  /// 二级分类名称
    
    var subcname: String?  /// 二级分类名称
    
    var scpic: String?   /// 二级分类图标

}
