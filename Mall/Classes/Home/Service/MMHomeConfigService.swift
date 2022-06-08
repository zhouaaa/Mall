//
//  MMHomeConfigService.swift
//  Mall
//
//  Created by iOS on 2022/5/27.
//

import UIKit
import RxSwift
import SwiftyJSON


class MMHomeConfigService: NSObject {

    @objc static let shared: MMHomeConfigService = MMHomeConfigService()
    
    fileprivate let _didUpdateConfig = PublishSubject<MMHomeMainModel>()
    
    fileprivate var isLoadParamSuccess = false
    
    /// 当前首页数据
    var homeConfig = MMHomeMainModel()
    
    private override init() {}
    
}


extension MMHomeConfigService {
    
    func loadHomeConfig() {
        _ = kHomeApiProvider.yn_request(.HomeCmsV2Ads(siteId:"369616", temp_id: "2", page: 1)).subscribe(onNext: { (json) in
            let result = MMHomeMainModel.deserialize(from: json) ?? MMHomeMainModel()
            self.homeConfig = result
            self._didUpdateConfig.onNext(result)
            self.isLoadParamSuccess = true
        }, onError: { error in
            self.isLoadParamSuccess = false
        })
    }
    
    /// 检查本地是否已加载首页配置参数
    func checkLocalConfigParam() {
        if !self.isLoadParamSuccess {
            loadHomeConfig()
        }
    }
    
    func handleSubscribeHomeConfig(json: MMHomeMainModel) {
        self.homeConfig = json
        self.isLoadParamSuccess = true
        _didUpdateConfig.onNext(json)
    }
    
}

extension Reactive where Base: MMHomeConfigService {
    
    /// 已更新配置
    var didUpdateConfig: Observable<MMHomeMainModel> {
        return base._didUpdateConfig.share()
    }
    
}
