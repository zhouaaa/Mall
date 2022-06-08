//
//  MMHomeSpikeDataModel.swift
//  Mall
//
//  Created by iOS on 2022/6/7.
//

import UIKit

class MMHomeSpikeDataModel: HandyJSONModel {
    
    var status: Int = 0

    var ddqTime: String?

    var roundsList: [MMHomeSpikeRoundModel]?

    var goodsList: [MMHomeSpikeModel]?
    
}


class MMHomeSpikeModel: HandyJSONModel {


    var couponStartTime: String?

    var tbcid: Int = 0

    var marketGroup: [String]?

    var mainPic: String?

    var ID: Int = 0

    var couponLink: String?

    var couponReceiveNum: Int = 0

    var monthSales: Int = 0

    var commissionRate: Int = 0

    var originalPrice: Double = 0

    var activityStartTime: String?

    var haitao: Int = 0

    var dailySales: Int = 0

    var estimateAmount: Int = 0

    var commissionType: Int = 0

    var sellerId: String?

    var couponConditions: String?

    var tchaoshi: Int = 0

    var brand: Int = 0

    var ddqDesc: String?

    var actualPrice: Double = 0

    var discounts: Double = 0

    var shopLevel: Int = 0

    var hzQuanOver: Int = 0

    var goodsId: String?

    var activityType: Int = 0

    var shopType: Int = 0

    var lowest: Int = 0

    var subcid: [String]?

    var yunfeixian: Int = 0

    var shopName: String?

    var cid: Int = 0

    var quanMLink: Int = 0

    var dtitle: String?

    var brandName: String?

    var couponPrice: Int = 0

    var brandId: Int = 0

    var couponEndTime: String?

    var createTime: String?

    var couponTotalNum: Int = 0

    var activityEndTime: String?

    var twoHoursSales: Int = 0

    var marketingMainPic: String?

    var specialText: [String]?

    var title: String?

    var itemLink: String?

}



class MMHomeSpikeRoundModel: HandyJSONModel {

    var ddqTime: String?

    var status: Int = 0
    
}

