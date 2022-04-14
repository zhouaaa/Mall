//
//  MMPreferentMainTableCell.swift
//  Mall
//
//  Created by iOS on 2022/4/14.
//

import UIKit

class MMPreferentMainTableCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.dynamicColor(UIColor.hexColor(0xffffff), darkColor: UIColor.hexColor(0x1A1A1A))
        self.layer(radius: 8, borderWidth: 0.0, borderColor: UIColor.dynamicColor(UIColor.hexColor(0xffffff), darkColor: UIColor.hexColor(0x1A1A1A)))
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var frame: CGRect {
        didSet {
            var newframe = frame
            newframe.origin.x += 12
            newframe.size.width -= 24
            newframe.origin.y += 8
            newframe.size.height -= 16
            super.frame = newframe
        }
    }
    
    
    private func setUI() {
        
        
        
    }
    
    
}
