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
    
}
