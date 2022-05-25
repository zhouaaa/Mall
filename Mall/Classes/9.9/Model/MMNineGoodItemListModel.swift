//
//  MMNineGoodItemListModel.swift
//  Mall
//
//  Created by iOS on 2022/5/12.
//

import UIKit

class MMNineGoodItemListModel: HandyJSONModel {
    
    var lists: [MMNineGoodItemModel]?

    var pageSize: Int = 0

    var totalCount: Int = 0
}


class MMNineGoodItemModel : HandyJSONModel {

    var isHaitao: Int = 0

    var lowest: Int = 0

    var xiaoliang: Int = 0

    var title: String?

    var beforePriceLabelType: Int = 0

    var beforeTitleLables: [MMNineGoodItemBeforetitlelablesModel]?

    var fresh: Int = 0

    var isShow: Int = 0

    var huodongType: Int = 0

    var jiage: Double = 0

    var yuanjia: Double = 0

    var quanJine: Int = 0

    var sellerId: String?

    var tmall: Int = 0

    var istmall: Int = 0

    var dtitle: String?

    var ID: Int = 0

    var pic: String?

    var thirtySellNun: Int = 0

    var yongjin: Int = 0

    var comments: String?

    var quanId: String?

    var shopLable: String?

    var goodsid: String?

    var comment: Int = 0

    var is_flagship: Int = 0

    var underPriceLabels: [String]?

}

class MMNineGoodItemBeforetitlelablesModel : HandyJSONModel {

    var img: String?

    var width: Int = 0

    var height: Int = 0

}


class MMNineTopGoodListModel : HandyJSONModel {

    var goodsList: [MMNineTopGoodModel]?

    var robbingNum: Int = 0
}

class MMNineTopGoodModel : HandyJSONModel {

    var ID: Int = 0

    var isShow: Int = 0

    var huodongType: Int = 0

    var istmall: Int = 0

    var yongjin: Double = 0

    var yuanjia: Double = 0

    var sellNum: Int = 0

    var pic: String?

    var beforePriceLabelType: Int = 0

    var quanId: String?

    var jiage: Double = 0

    var shortTag: String?

    var title: String?

    var tmall: Int = 0

    var goodsid: String?

    var dtitle: String?

    var xiaoliang: Int = 0

    var quanJine: Int = 0

}

