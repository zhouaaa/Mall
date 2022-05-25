//
//  MMHomeLargeCouponMenuModel.swift
//  Mall
//
//  Created by iOS on 2022/5/13.
//

import UIKit

class MMHomeLargeCouponMenuModel: HandyJSONModel {

    var floor: [MMHomeLargeCouponItemModel]?

    var ID: String?

    var title: String?

    var bottomAds: [String]?

    var tempType: String?

    var background: String?

    var floorTab: [String]?

}


class MMHomeLargeCouponItemModel: HandyJSONModel {
    
    var ID: Int = 0

    var title: String?

    var config: MMHomeLargeCouponItemConfigModel?

    var type: Int = 0

    var background: String?
}



class MMHomeLargeCouponItemConfigModel : HandyJSONModel {

    var banner: [MMHomeLargeCouponBannerItemConfigModel]?
    
    var type: Int = 0

    var url: String?
    
}

class MMHomeLargeCouponBannerItemConfigModel : HandyJSONModel {
    
    var c_type: Int = 0
    
    var url: String?
    
    var pic: String?
    
}

///==============================

class MMHomeLargeCouponGoodListModel : HandyJSONModel {

    var totalNum: Int = 0

    var list: [MMHomeLargeCouponGoodItemModel]?

    var pageId: String?

}

class MMHomeLargeCouponGoodItemModel : HandyJSONModel {

    var couponLink: String?

    var activityType: Int = 0

    var dsrScore: Double = 0

    var activityStartTime: String?

    var yunfeixian: Int = 0

    var twoHoursSales: Int = 0

    var ID: Int = 0

    var itemLink: String?

    var discounts: Double = 0

    var video: String?

    var directCommission: Int = 0

    var cpaRewardAmount: Int = 0

    var serviceScore: Double = 0

    var sellerId: String?

    var couponId: String?

    var subcid: [String]?

    var goodsId: String?

    var goldSellers: Int = 0

    var shopLevel: Int = 0

    var marketGroup: [String]?

    var brandWenan: String?

    var title: String?

    var couponTotalNum: Int = 0

    var activityId: String?

    var discountCut: Int = 0

    var dtitle: String?

    var quanMLink: Int = 0

    var cid: Int = 0

    var haitao: Int = 0

    var desc: String?

    var shopLogo: String?

    var brand: Int = 0
    
    var couponConditions: String?

    var shipPercent: Double = 0

    var servicePercent: Double = 0

    var couponReceiveNum: Int = 0

    var hzQuanOver: Int = 0

    var freeshipRemoteDistrict: Int = 0

    var couponPrice: Int = 0

    var brandId: Int = 0

    var monthSales: Int = 0

    var tchaoshi: Int = 0

    var discountType: Int = 0

    var zsFullMinusInfo: String?

    var directCommissionLink: String?

    var originalPrice: Int = 0

    var mainPic: String?

    var dsrPercent: Double = 0

    var previewStartTime: String?

    var discountFull: Int = 0

    var activityEndTime: String?

    var inspectedGoods: Int = 0

    var tbcid: Int = 0

    var teamName: String?

    var actualPrice: Int = 0

    var lowest: Int = 0

    var marketingMainPic: String?

    var couponEndTime: String?

    var shopName: String?

    var descScore: Double = 0

    var hotPush: Int = 0

    var estimateAmount: Int = 0

    var directCommissionType: Int = 0

    var dailySales: Int = 0

    var commissionRate: Int = 0

    var specialText: [String]?

    var createTime: String?

    var shipScore: Double = 0

    var activityInfo: [String]?

    var commissionType: Int = 0

    var brandName: String?

    var shopType: Int = 0

    var couponStartTime: String?

}


