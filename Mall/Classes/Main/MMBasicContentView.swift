//
//  MMBasicContentView.swift
//  Mall
//
//  Created by iOS on 2022/3/1.
//

import UIKit
import ESTabBarController_swift

class MMBasicContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        renderingMode = .alwaysOriginal
        
        textColor = UIColor.hexColor(0x646564)
        highlightTextColor = UIColor.hexColor(0xf21724)

        iconColor = UIColor.hexColor(0x646564)
        highlightIconColor = UIColor.hexColor(0xf21724)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
