//
//  MMCategorieTableLeftCell.swift
//  Mall
//
//  Created by iOS on 2022/2/24.
//

import UIKit

class MMCategorieTableLeftCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.dynamicColor(UIColor.hexColor(0xffffff), darkColor: UIColor.hexColor(0x1A1A1A))
        
        self.setleftCategoryCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置选中样式
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = selected ? UIColor.white
        : UIColor.hexColor(0xF8F8FA)
        isHighlighted = selected
        titleLabel.isHighlighted = selected
        lineView.isHidden = !selected
    }
    
    //在底部绘制1像素的线条
    override func draw(_ rect: CGRect) {
            
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        //线宽
        let lineWidth = 1 / UIScreen.main.scale
        //线偏移量
        let lineAdjustOffset = 1 / UIScreen.main.scale / 2
            
        //创建一个矩形，它的所有边都内缩固定的偏移量
        let drawingRect = self.bounds.insetBy(dx: lineAdjustOffset, dy: lineAdjustOffset)
        
        //创建并设置路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: drawingRect.maxY))
        path.addLine(to: CGPoint(x: self.bounds.width, y: drawingRect.maxY))
            
        //添加路径到图形上下文
        context.addPath(path)
         
        //设置笔触颜色 //#
        context.setStrokeColor(UIColor.hexColor(0xF8F9F9).cgColor)
            
        //设置笔触宽度
        context.setLineWidth(lineWidth)
            
        //绘制路径
        context.strokePath()
    }
    
    
    private func setleftCategoryCellUI() {
        
        self.contentView.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(contentView.snp.top).offset(5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.width.equalTo(3)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
        }
        
    }

    func reloadLeftCellData(cellData: MMCategoryListModel) {
        titleLabel.text = cellData.cname
    }
    
    private lazy var titleLabel: UILabel = {
        let _lab = UILabel()
        _lab.textColor = UIColor.dynamicColor(UIColor.hexColor(0x333333), darkColor: UIColor.hexColor(0x999999))
        _lab.highlightedTextColor = UIColor.hexColor(0xf21724)
        _lab.textAlignment = .center
        return _lab
    }()
    
    private lazy var lineView: UIView = {
        let _v = UIView()
        _v.backgroundColor = UIColor.hexColor(0xf21724)
        return _v
    }()
}
