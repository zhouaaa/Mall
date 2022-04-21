//
//  MMNineCateItemModel.swift
//  Mall
//
//  Created by iOS on 2022/4/21.
//

import UIKit
import SwiftyJSON


class MMNineCateItemModel: HandyJSONModel {
    
    var id: String?

    var title: String?

    var navList: [MMNineCateItemNavModel]?

    var originId: Int = 0

    var type: Int = 0
}

class MMNineCateItemNavModel: HandyJSONModel {
    
    var id: Int = 0

    var title: String?
    
}

