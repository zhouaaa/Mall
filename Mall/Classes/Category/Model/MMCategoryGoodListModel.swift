//
//  MMCategoryGoodListModel.swift
//  Mall
//
//  Created by iOS on 2022/4/1.
//

import UIKit

class MMCategoryGoodListModel: HandyJSONModel {

    var pageId: Int? = 0
    /// 淘宝 京东用
    var totalNum: Int?
    /// 抖音用
    var total: Int?
    
    /// 商品数据
    var list: [MMCategoryPublicGoodModel]?
    
}

class MMCategoryPublicGoodModel: HandyJSONModel {

    /// ====  公用 ==== ///
    var price: Double?
    var shopName: String?
    var shopId: String?
    var title: String?
    var shopLevel: String?
    var brandName: String?
    var couponPrice: Int?
    
    ///   === 抖音 ===   ///
    var cosFee: Int?
    
    var cosRatio: Int?
    
    /// 商品封面
    var cover: String?
    /// 商品详情链接🔗
    var detailUrl: String?
    
    var firstCid: String?
    
    var inStock: Bool?
    
    var productId: String?
    
    var sales: Int?
    
    var secondCid: String?
    
    var sharable: Bool?
    
    var thirdCid: String?
    
    ///    ==== 京东 =====   ///
    var cid1: String?
    
    var cid1Name: String?
    
    var cid2: String?
    
    var cid2Name: String?
    
    var cid3: String?
    
    var cid3Name: String?
    
    var comments: Int?
    
    var commission: Int?
    
    var commissionShare: Int?
    
    var couponCommission: Int?
    
    var plusCommissionShare: Int?
    
    var isLock: Bool?
    
    var commissionStartTime: String?
    
    var commissionEndTime: String?
    
    /// 优惠券列表
    var couponList: [MMCategoryGoodJDCouponListModel]?
    
    var goodCommentsShare: Int?
    
    var whiteImage: String?
    
    /// 商品图片数组
    var imageUrlList: [String]?
    
    var inOrderCount30Days: Int?
    
    /// 商品详情跳转链接
    var materialUrl: String?
    
    var lowestPrice: Double?
    
    var lowestPriceType: Int?
    
    var lowestCouponPrice: Int?
    
    var shopLabel: String?
    
    var userEvaluateScore: Int?
    
    var commentFactorScoreRankGrade: Int?
    
    var logisticsLvyueScore: Int?
    
    var logisticsFactorScoreRankGrade: Int?
    
    var afterServiceScore: String?
    
    var afsFactorScoreRankGrade: Int?
    
    var scoreRankRate: String?
    
    var skuId: String?
    
    var skuName: String?
    
    var spuid: String?
    
    var brandCode: String?
    
    var owner: String?
    
    var videoList: [String]?
    
    var commentList: [String]?
    
    var jxFlags: [String]?
    
    var document: String?
    
    var discount: Int?
    
    ///   ==== 淘宝 ===   ///
    var id: String?
    
    var goodsId: String?
    
    var dtitle: String?
    
    /// 原价
    var originalPrice: Double?
    
    /// 折后价
    var actualPrice: Double?
    /// 店铺类型，1-天猫，0-淘宝
    var shopType: Int?
    
    var goldSellers: Int?
    
    var monthSales: Int?
    
    var twoHoursSales: Int?
    
    var dailySales: Int?
    /// 佣金类型，0-通用，1-定向，2-高佣，3-营销计划
    var commissionType: Int?
    
    var desc: String?
    
    var couponRemainCount: Int?
    
    var couponReceiveNum: Int?
    
    var couponLink: String?
    
    var couponEndTime: String?
    
    var couponStartTime: String?
    
    var couponConditions: String?
    
    var couponId: String?
    /// 活动类型，1-无活动，2-淘抢购，3-聚划算
    var activityType: Int?
    
    var createTime: String?
    
    var activityId: String?
    
    var cpaRewardAmount: String?
    
    var mainPic: String?
    
    var marketingMainPic: String?
    
    var sellerId: String?
    
    var brandWenan: String?
    
    var cid: String?
    
    var tbcid: String?
    
    var descScore: Int?
    
    var dsrScore: Int?
    
    var dsrPercent: Int?
    
    var shipScore: Int?
    
    var shipPercent: Int?
    
    var serviceScore: Int?
    
    var servicePercent: Int?
    
    var estimateAmount: Int?
    
    var discounts: Int?
    
    var discountFull: Int?
    
    var discountCut: Int?
    
    var commissionRate: Int?
    
    var brand: String?
    
    var brandId: String?
    
    var hotPush: Int?
    
    var couponTotalNum: Int?
    
    var quanMLink: String?
    
    var hzQuanOver: String?
    
    var yunfeixian: String?
    
    var discountType: String?
    
    var inspectedGoods: String?
    
    var lowest: String?
    
    var haitao: Bool?
    
    var itemLink: String?
    
    var teamName: String?
    
    var activityStartTime: String?
    
    var activityEndTime: String?
    
    var smallImages: [String]?
    
    var specialText: [AnyObject]?
    
    var activityInfo: AnyObject?
    
    var marketGroup: [AnyObject]?
    
    var subcid: [AnyObject]?
}


class MMCategoryGoodJDCouponListModel: HandyJSONModel {
    
    var bindType: String?

    var link: String?
    
    var platformType: String?
    
    var discount: Int?
    
    var quota: Int?
    
    var getStartTime: String?
    
    var getEndTime: String?
    
    var useStartTime: String?
    
    var useEndTime: String?
    
    var isBest: Bool?
    
    var hotValue: Int?
    
    var isInputCoupon: Bool?
}

