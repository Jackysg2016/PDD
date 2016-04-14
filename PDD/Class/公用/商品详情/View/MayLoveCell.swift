//
//  MayLoveCell.swift
//  PDD
//
//  Created by 周磊 on 16/4/13.
//  Copyright © 2016年 ZL. All rights reserved.
//  可能喜欢

import UIKit

class MayLoveCell: UICollectionViewCell {
    
    var mayLoveLabel:UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let topView = UIView()
        topView.backgroundColor = BgColor
        self.contentView.addSubview(topView)
        topView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(0)
            make.height.equalTo(10)
        }
        
        mayLoveLabel = UILabel()
        mayLoveLabel?.font = UIFont.systemFontOfSize(13)
        mayLoveLabel?.textColor = UIColor.blackColor()
        mayLoveLabel!.text = "您可能还喜欢"
        self.contentView.addSubview(mayLoveLabel!)
        mayLoveLabel?.snp_makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.snp_centerY).offset(5)
            make.left.equalTo(self).offset(10)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
