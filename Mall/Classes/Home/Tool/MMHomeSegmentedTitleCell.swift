//
//  MMHomeSegmentedTitleCell.swift
//  Mall
//
//  Created by iOS on 2022/5/12.
//

import UIKit
import JXSegmentedView

class MMHomeSegmentedTitleCell: JXSegmentedTitleCell {
 
    public let subLabel = UILabel()
    
    override func commonInit() {
        super.commonInit()
        
        subLabel.textAlignment = .center
        contentView.addSubview(subLabel)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelSize = titleLabel.sizeThatFits(self.contentView.bounds.size)
        let labelBounds = CGRect(x: 0, y: 0, width: labelSize.width, height: labelSize.height)
        titleLabel.bounds = labelBounds
        titleLabel.center = CGPoint(x: contentView.centerX, y: contentView.centerY*0.5)

        maskTitleLabel.bounds = labelBounds
        maskTitleLabel.center = CGPoint(x: contentView.centerX, y: contentView.centerY*0.65)
        
        let subSize = subLabel.sizeThatFits(self.contentView.bounds.size)
        let subBounds = CGRect(x: 0, y: 0, width: subSize.width + subSize.height * 1.4, height: subSize.height*1.4)
        subLabel.bounds = subBounds
        subLabel.center = CGPoint(x: contentView.centerX, y: contentView.centerY*1.4)
        subLabel.layer(radius: subSize.height*0.7, borderWidth: 0.0, borderColor: UIColor.white)
        
    }

    override func reloadData(itemModel: JXSegmentedBaseItemModel, selectedType: JXSegmentedViewItemSelectedType) {
        super.reloadData(itemModel: itemModel, selectedType: selectedType )

        guard let myItemModel = itemModel as? MMHomeSegmentedTitleItemModel else {
            return
        }
        
        self.subLabel.text = myItemModel.subtitle
       
        if myItemModel.isSelected == true {
            self.subLabel.textColor = UIColor.white
            self.subLabel.backgroundColor = UIColor.hexColor(0xEE0A24)
            self.subLabel.font = myItemModel.subtitleSelectedFont
        }
        else
        {
            self.subLabel.textColor = UIColor.hexColor(0x999999)
            self.subLabel.backgroundColor = UIColor.clear
            self.subLabel.font = myItemModel.subtitleNormalFont
        }
    }
}
