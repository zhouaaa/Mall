//
//  UIScrollView+MMRefresh.swift
//  Mall
//
//  Created by iOS on 2022/4/1.
//

import UIKit
import MJRefresh
import YYKit

extension UIScrollView {
    
    var MMHead: MJRefreshHeader? {
        get { return mj_header }
        set { mj_header = newValue }
    }
    
    var MMFoot: MJRefreshFooter? {
        get { return mj_footer }
        set { mj_footer = newValue }
    }
    
    func endRefreshing() {
        
        if self.mj_header?.isRefreshing ?? false{
            self.mj_header?.endRefreshing()
            self.mj_footer?.resetNoMoreData()
        }
        
        if self.mj_footer?.isRefreshing ?? false {
            self.mj_footer?.endRefreshing()
        }
        
    }
}



enum RefreshViewState {
    case idle, loading, error, nomore
}

protocol RefreshView {
    var viewForState: ((RefreshViewState) -> UIView?)? {get set}
}

extension RefreshView where Self: RefreshFooter {
    
}

public class RefreshHeader: MJRefreshNormalHeader {
    override public func prepare() {
        super.prepare()
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel?.isHidden = true
    }
}

public class RefreshFooter: MJRefreshAutoStateFooter {
    
    var noMoreDataView: UIView? = nil {
        didSet {
            if let item = noMoreDataView {
                addSubview(item)
                item.snp.makeConstraints({$0.edges.equalToSuperview()})
                item.isHidden = true
            }
        }
    }
    
    override public func prepare() {
        super.prepare()
        setTitle("", for: .idle)
        setTitle("", for: .noMoreData)
    }
    
    public override func resetNoMoreData() {
        super.resetNoMoreData()
        noMoreDataView?.isHidden = true
        stateLabel?.isHidden = false
    }
    
    public override func endRefreshingWithNoMoreData() {
        super.endRefreshingWithNoMoreData()
        if let item = noMoreDataView {
            item.isHidden = false
            stateLabel?.isHidden = true
        }
    }
}

public class CustomGifHeader:MJRefreshGifHeader{
    
    public override func prepare() {
        super .prepare()
        //GIF??????
        let idleImages = self.getRefreshingImageArray(start: 1, end: 14)
        let refrrshImages = self.getRefreshingImageArray(start: 1, end: 14)
        //            //????????????
        self.setImages(idleImages, for: .idle)
        //            //??????????????????
        self.setImages(refrrshImages, for: .refreshing)
        //            //??????????????????
        self.setImages(refrrshImages, for: .pulling)
    }
    
///    #pragma mark - ??????????????????
    private func getRefreshingImageArray(start:Int,end:Int) -> Array<UIImage> {
        var imageArray:Array<UIImage> = []
        for item in start...end {
            var image = UIImage(named: "refresh_\(item)")
            if image != nil {
               image = image?.scale(to: CGSize(width: 50, height: 50))
                imageArray.append(image!)
            }
        }
        return imageArray
    }
    /// ??????????????????????????????
    public override func placeSubviews() {
        super.placeSubviews()
        self.stateLabel?.isHidden = true
        self.lastUpdatedTimeLabel?.isHidden = true
    }
}


extension UIImage {
    
    /// ??????????????????UIImage??????????????????UIImage
    ///
    /// - Parameter size: ??????????????????
    /// - Returns: ????????????UIImage??????
    public func scale(to size: CGSize, scale: CGFloat? = nil) -> UIImage {
        let _scale = scale ?? UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(size, false, _scale)
        
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let _image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return _image!
    }
}
