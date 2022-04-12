//
//  MMHomeMainModel.swift
//  Mall
//
//  Created by iOS on 2022/4/8.
//

import UIKit
import SwiftyJSON

class MMHomeMainModel: HandyJSONModel {
    
    var version: Int = 0

    var styles: MMHomeStylesModel?

    var activity_info: MMHomeActivityInfoModel?

    var activity_child_showcase: [String]?

    var navigation_activity: [String]?

    var activity_main_showcase: [String]?

    var h_banners: [MMHomeIconBannerModel]?

    var jd_icons: [MMHomeIconBannerModel]?

    var icons: [MMHomeIconBannerModel]?

    var w_banners: [MMHomeIconBannerModel]?
    
    var small_icons: [MMHomeIconBannerModel]?
    
    var jd_banner: [MMHomeIconBannerModel]?
    
    var bottom_navigation: [String]?

}

class MMHomeActivityInfoModel : HandyJSONModel {

    var activity_title: String?

    var activity_banner_url: String?

    var activity_id: String?

    var activity_show_classify: Int = 0

}

//===========  Styles ========= ///

class MMHomeStylesModel : HandyJSONModel {

    var main_showcase: MMHomeStylesMainShowcaseModel?

    var bottom_navigation: MMHomeStylesBottomNavigation?

    var xb: MMHomeStylesIconsModelXbModel?

    var search_entrance: MMHomeStylesSearchEntrance?

    var w_banners: MMHomeStylesWBannersModel?

    var activity_main_showcase: MMHomeStylesActivityMainShowcase?

    var top: MMHomeStylesTopModel?

    var navigation_activity: MMHomeStylesNavigationActivityModel?

    var top_entrance: MMHomeStylesTop_EntranceModel?

    var icons: MMHomeStylesIconsModel?

}

class MMHomeStylesIconsModel : HandyJSONModel {

    var bg_url: String?

    var bg_color: String?

    var font_color: String?

}

class MMHomeStylesBottomNavigation : HandyJSONModel {

    var font_color: String?

    var bg_url: String?

    var font_color_choose: String?

    var bg_color: String?

}

class MMHomeStylesIconsModelXbModel : HandyJSONModel {

    var bg_url: String?

    var bg_color: String?

}

class MMHomeStylesSearchEntrance : HandyJSONModel {

    var bg_url: String?

    var bg_color: String?

}

class MMHomeStylesWBannersModel : HandyJSONModel {

    var bg_url: String?

    var bg_color: String?

}

class MMHomeStylesActivityMainShowcase : HandyJSONModel {

    var bg_url: String?

    var bg_color: String?

}

class MMHomeStylesTopModel : HandyJSONModel {

    var bg_url: String?

    var bg_color: String?

}

class MMHomeStylesMainShowcaseModel : HandyJSONModel {

    var bg_url: String?

    var bg_color: String?

}

class MMHomeStylesNavigationActivityModel : HandyJSONModel {

    var font_color: String?

    var bg_url: String?

    var font_underline: String?

    var font_color_choose: String?

    var bg_color: String?

}

class MMHomeStylesTop_EntranceModel : HandyJSONModel {

    var bg_url: String?

    var bg_color: String?
}

//===========  Styles ========= ///


class MMHomeIconBannerModel : HandyJSONModel {

    var title: String?
    
    var img: String?
    
    var c_type: String?
    
    var url: String?
    
    var `in`: Int = 0
    
}



