//
//  HandyJSONModel.swift
//  Mall
//
//  Created by iOS on 2022/2/23.
//

import UIKit
import HandyJSON
import SwiftyJSON

class HandyJSONModel: NSObject, HandyJSON {
    
    required public override init() {
        
    }
    
    public static func deserialize(from json: JSON) -> Self? {
        return self.deserialize(from: json.dictionaryObject)
    }
    
    func mapping(mapper: HelpingMapper) {
        //自定义解析规则，日期数字颜色，如果要指定解析格式，子类实现重写此方法即可
        //        mapper <<<
        //            date <-- CustomDateFormatTransform(formatString: "yyyy-MM-dd")
        //
        //        mapper <<<
        //            decimal <-- NSDecimalNumberTransform()
        //
        //        mapper <<<
        //            url <-- URLTransform(shouldEncodeURLString: false)
        //
        //        mapper <<<
        //            data <-- DataTransform()
        //
        //        mapper <<<
        //            color <-- HexColorTransform()
    }
}
