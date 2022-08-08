//
//  UIImageView+Kingfisher.swift
//  Mall
//
//  Created by iOS on 2022/8/5.
//

import Foundation
import UIKit
import Kingfisher

enum ImageResult {
    case success(UIImage)
    case failure(String)
}

extension UIImageView {
    
    /// 设置网络图片及占位图
    ///
    /// - Parameters:
    ///   - url: 网络图片资源url
    ///   - placeholder: 占位图片名称
    func setImageWithURL(_ url: String?) {
        guard let imageURL = url?.URLValue else {
            return
        }
        
        let optionInfoBuffer: KingfisherOptionsInfo = [
                        .backgroundDecode,
                        .transition(ImageTransition.fade(0.35)),
                        .fromMemoryCacheOrRefresh,
                        .keepCurrentImageWhileLoading
                    ]
        
        self.kf.setImage(with: imageURL, placeholder:kGlobalDefultImage, options: optionInfoBuffer)
    }
    

    
    /// 下载网络图片资源
    ///
    /// - Parameters:
    ///   - url: 网络图片资源url
    ///   - placeholder: 占位图片名称
    ///   - callback: 下载完成回调
    func downloadImageWithURL(_ url: String,
                              placeholder: UIImage = UIImage(),
                              callback:(@escaping (ImageResult) -> ())) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        kf.setImage(with: imageURL, placeholder: placeholder, options: [.downloadPriority(0.9), .transition(.fade(1)), .fromMemoryCacheOrRefresh]) { (result) in
            switch result{
            case .success(let value):
                NSLog("Task done for: \(value.source.url?.absoluteString ?? "")")
                callback(ImageResult.success(self.image!))
            case .failure(let error):
                NSLog("Job failed: \(error.localizedDescription)")
                callback(ImageResult.failure((error as NSError).domain))
            }
        }
    }
}

public protocol URLConvertibleProtocol {
    var URLValue: URL? { get }
    var URLStringValue: String { get }
}

extension String: URLConvertibleProtocol {
    ///String转换成URL
    public var URLValue: URL? {
        if let URL = URL(string: self) {
            return URL
        }
        let set = CharacterSet()
            .union(.urlHostAllowed)
            .union(.urlPathAllowed)
            .union(.urlQueryAllowed)
            .union(.urlFragmentAllowed)
        return self.addingPercentEncoding(withAllowedCharacters: set).flatMap { URL(string: $0) }
    }
    public var URLStringValue: String {
        return self
    }
}
