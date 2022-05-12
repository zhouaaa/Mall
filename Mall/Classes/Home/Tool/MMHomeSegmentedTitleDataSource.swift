//
//  MMHomeSegmentedTitleDataSource.swift
//  Mall
//
//  Created by iOS on 2022/5/12.
//

import UIKit
import JXSegmentedView

class MMHomeSegmentedTitleDataSource: JXSegmentedTitleDataSource {
    
    open var subtitles = [String]()
    
    open var subtitleNormalFont: UIFont = UIFont.systemFont(ofSize: 15)
    /// title选中时的字体。如果不赋值，就默认与titleNormalFont一样
    open var subtitleSelectedFont: UIFont  = UIFont.systemFont(ofSize: 15)
    
    override func registerCellClass(in segmentedView: JXSegmentedView) {
        segmentedView.collectionView.register(MMHomeSegmentedTitleCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func preferredItemModelInstance() -> JXSegmentedBaseItemModel {
        return MMHomeSegmentedTitleItemModel()
    }
    
    override func preferredRefreshItemModel(_ itemModel: JXSegmentedBaseItemModel, at index: Int, selectedIndex: Int) {
        super.preferredRefreshItemModel(itemModel, at: index, selectedIndex: selectedIndex)

        guard let myItemModel = itemModel as? MMHomeSegmentedTitleItemModel else {
            return
        }

        myItemModel.title = titles[index]
        myItemModel.subtitleNormalFont = subtitleNormalFont
        myItemModel.subtitleSelectedFont = subtitleSelectedFont
        
        myItemModel.subtitle = subtitles[index]
        myItemModel.textWidth = widthForTitle(myItemModel.title ?? "")
        myItemModel.titleNumberOfLines = titleNumberOfLines
        myItemModel.isSelectedAnimable = isSelectedAnimable
        myItemModel.titleNormalColor = titleNormalColor
        myItemModel.titleSelectedColor = titleSelectedColor
        myItemModel.titleNormalFont = titleNormalFont
        myItemModel.titleSelectedFont = titleSelectedFont != nil ? titleSelectedFont! : titleNormalFont
        myItemModel.isTitleZoomEnabled = isTitleZoomEnabled
        myItemModel.isTitleStrokeWidthEnabled = isTitleStrokeWidthEnabled
        myItemModel.isTitleMaskEnabled = isTitleMaskEnabled
        myItemModel.titleNormalZoomScale = 1
        myItemModel.titleSelectedZoomScale = titleSelectedZoomScale
        myItemModel.titleSelectedStrokeWidth = titleSelectedStrokeWidth
        myItemModel.titleNormalStrokeWidth = 0
        if index == selectedIndex {
            myItemModel.titleCurrentColor = titleSelectedColor
            myItemModel.titleCurrentZoomScale = titleSelectedZoomScale
            myItemModel.titleCurrentStrokeWidth = titleSelectedStrokeWidth
        }else {
            myItemModel.titleCurrentColor = titleNormalColor
            myItemModel.titleCurrentZoomScale = 1
            myItemModel.titleCurrentStrokeWidth = 0
        }
    }
}
